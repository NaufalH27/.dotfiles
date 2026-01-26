pragma Singleton
import qs.configs
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQml

Singleton {
  id: root


  readonly property int minimizedWorkspaceOffset: 10

  function isMinimizedWorkspace(rawId) {
    return rawId > minimizedWorkspaceOffset
  }

  function normalizeWorkspaceId(rawId) {
    return isMinimizedWorkspace(rawId)
      ? rawId - minimizedWorkspaceOffset
      : rawId
  }

  function minimizedWorkspaceId(baseId) {
    return baseId + minimizedWorkspaceOffset
  }


  readonly property var workspaces: Hyprland.workspaces
  readonly property var monitors: Hyprland.monitors
  readonly property var workspacesValues: workspaces.values
  readonly property var monitorsValues: monitors.values

  readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
  readonly property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
  readonly property HyprlandToplevel activeToplevel: Hyprland.activeToplevel
  readonly property int activeWsId: focusedWorkspace?.id ?? 1

  property int maxWsId: Config.system.ui.minNumberOfPillShown
  property bool isActiveWsEmpty: false



  property string clientIpc: ""
  property var toplevelByAddress: ({})

  onClientIpcChanged: updateWorkspaceModelTopLevel()


  ListModel { id: workspaceModel }
  property alias workspaceModel: workspaceModel

  function dispatch(request: string): void {
    Hyprland.dispatch(request)
  }

  function getWorkspaceById(id) {
      return workspaceModel.get(id) || null
  }


  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      Hyprland.refreshWorkspaces()
      Hyprland.refreshMonitors()
      Hyprland.refreshToplevels()
      root.updateWorkspaceModel()

      if (event.name === "urgent" && event.data) {
        root.moveUrgent(event.data)
      }
    }
  }


  function moveUrgent(urgentAddr: string) {
    const address = urgentAddr.startsWith("0x")
      ? urgentAddr
      : "0x" + urgentAddr

    const tl = toplevelByAddress[address]
    if (!tl) return

    if (tl.minimized) {
      root.dispatch(`movetoworkspacesilent ${tl.workspaceId}, address:${address}`)
    }

    if(tl.workspaceId !== activeWsId) {
      root.dispatch(`workspace ${tl.workspaceId}`)
    }
    if(tl.fullscreen > 0) {
      root.dispatch(`fullscreen ${tl.fullscreen}`)
      root.dispatch(`fullscreen ${tl.fullscreen}`)
    }
    root.dispatch(`focuswindow address:${address}`)
    root.dispatch(`bringactivetotop`)
  }


  function updateWorkspaceModelTopLevel() {
    const start = clientIpc.indexOf('[')
    const end = clientIpc.lastIndexOf(']')

    if (start === -1 || end === -1)
      return

    for (let i = 0; i < workspaceModel.count; i++)
      workspaceModel.get(i).toplevels.clear()

    toplevelByAddress = {}

    const json = clientIpc.slice(start, end + 1)
    const toplevels = JSON.parse(json).sort(
      (a, b) => (b.focusHistoryID ?? 0) - (a.focusHistoryID ?? 0)
    )

    let activeEmpty = true

    for (let i = toplevels.length - 1; i >= 0; --i) {
      const o = toplevels[i]
      const rawWsId = o.workspace?.id ?? -1
      const wsId = normalizeWorkspaceId(rawWsId)

      if (rawWsId === activeWsId)
        activeEmpty = false

      const toplevel = {
        address: o.address,
        pid: o.pid,

        mapped: o.mapped ?? false,
        hidden: o.hidden ?? false,
        floating: o.floating ?? false,
        pinned: o.pinned ?? false,
        fullscreen: o.fullscreen ?? 0,
        fullscreenClient: o.fullscreenClient ?? 0,
        overFullscreen: o.overFullscreen ?? false,
        pseudo: o.pseudo ?? false,
        xwayland: o.xwayland ?? false,
        inhibitingIdle: o.inhibitingIdle ?? false,

        class: o.class,
        title: o.title,
        initialClass: o.initialClass === "floatingTerminal" ? "kitty" : o.initialClass,
        initialTitle: o.initialTitle,

        x: o.at?.[0] ?? 0,
        y: o.at?.[1] ?? 0,
        width: o.size?.[0] ?? 0,
        height: o.size?.[1] ?? 0,

        workspaceId: wsId,
        workspaceName: o.workspace?.name ?? "",

        monitor: o.monitor ?? -1,
        contentType: o.contentType ?? "none",

        grouped: o.grouped ?? [],
        tags: o.tags ?? [],

        swallowing: o.swallowing ?? "0x0",
        focusHistoryID: o.focusHistoryID ?? 0,

        xdgTag: o.xdgTag ?? "",
        xdgDescription: o.xdgDescription ?? "",

        minimized: isMinimizedWorkspace(rawWsId)
      }

      toplevelByAddress[toplevel.address] = toplevel

      if (wsId < 1 || wsId > workspaceModel.count)
        continue

      workspaceModel.get(wsId - 1).toplevels.append(toplevel)
    }

    root.isActiveWsEmpty = activeEmpty
  }


  Process {
    id: getToplevels
    running: true
    command: [ "hyprctl", "clients", "-j" ]

    stdout: StdioCollector {
      onStreamFinished: root.clientIpc = this.text
    }
  }


  function updateWorkspaceModel() {
    for (let i = 0; i < workspaceModel.count; i++) {
      workspaceModel.setProperty(i, "exists", false)
      workspaceModel.setProperty(i, "active", false)
      workspaceModel.setProperty(i, "urgent", false)
      workspaceModel.setProperty(i, "special", false)
    }

    let maxId = Config.system.ui.minNumberOfPillShown

    for (let ws of workspaces.values) {
      const wsId = normalizeWorkspaceId(ws.id)
      if (wsId < 1 || wsId > workspaceModel.count)
        continue

      const i = wsId - 1
      workspaceModel.setProperty(i, "exists", true)
      workspaceModel.setProperty(i, "active", ws.active)
      workspaceModel.setProperty(i, "urgent", ws.urgent)

      if (wsId > maxId)
        maxId = wsId
    }

    root.maxWsId = maxId

    getToplevels.running = false
    getToplevels.running = true
  }

  Component.onCompleted: {
    workspaceModel.clear()

    for (let i = 1; i <= Config.system.ui.maxNumberOfPillShown; i++) {
      workspaceModel.append({
        wsId: i,
        exists: false,
        active: false,
        urgent: false,
        toplevels: []
      })
    }

    updateWorkspaceModel()
  }
}

