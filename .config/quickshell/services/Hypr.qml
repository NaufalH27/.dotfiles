pragma Singleton
import qs.configs
import qs.utils
import Quickshell
import Quickshell.Hyprland
import QtQml

Singleton {
  id: root

  readonly property var toplevels: Hyprland.toplevels
  readonly property var workspaces: Hyprland.workspaces
  readonly property var monitors: Hyprland.monitors
  readonly property var toplevelsValues: toplevels.values
  readonly property var workspacesValues: workspaces.values
  readonly property var monitorsValues: monitors.values
  readonly property HyprlandToplevel activeToplevel: Hyprland.activeToplevel 
  readonly property var activeToplevelTitle : activeToplevel?.title
  readonly property var activeToplevelInitialClass : activeToplevel?.lastIpcObject.initialClass

  readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
  readonly property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
  readonly property int activeWsId: focusedWorkspace?.id ?? 1
  property int maxWsId: Config.system.ui.minNumberOfPillShown
  property bool isSpecialActive: false
  onWorkspacesValuesChanged: updateWorkspaceModel() 
  onToplevelsValuesChanged: {
    updateWorkspaceModel() 
  } 
  onActiveToplevelTitleChanged: {
    updateWorkspaceModel() 
  } 
  onActiveToplevelChanged: {
    updateWorkspaceModel() 
  } 
  onActiveToplevelInitialClassChanged: {
    updateWorkspaceModel() 
  } 
  onFocusedWorkspaceChanged: updateWorkspaceModel() 

  ListModel {
    id: workspaceModel
  }
  readonly property alias workspaceModel: workspaceModel

  signal configReloaded

  function dispatch(request: string): void {
    Hyprland.dispatch(request)
  }

  function monitorFor(screen: ShellScreen): HyprlandMonitor {
    return Hyprland.monitorFor(screen)
  }



  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      const n = event.name
      const data = event.data

      if (n === "configreloaded") {
        root.configReloaded()
      } else if (["workspace", "moveworkspace", "focusedmon"].includes(n)) {
        Hyprland.refreshWorkspaces()
        Hyprland.refreshMonitors()
      } else if (n.includes("activespecial")){
        if (data.includes("special:special")){
          root.isSpecialActive = true
        } else {
          root.isSpecialActive = false
        }
        Hyprland.refreshToplevels()
        Hyprland.refreshWorkspaces()

      }else if (["openwindow", "closewindow", "movewindow"].includes(n)) {
        Hyprland.refreshToplevels()
        Hyprland.refreshWorkspaces()
      } else if (n.includes("mon")) {
        Hyprland.refreshMonitors()
      } else if (n.includes("workspace")) {
        Hyprland.refreshWorkspaces()
      } else if (
        n.includes("window") ||
        n.includes("group") ||
        ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(n)
      ) {
        Hyprland.refreshToplevels()
      }
    }
  }

  function updateWorkspaceModel() {
    for (let i = 0; i < workspaceModel.count; i++) {
      workspaceModel.setProperty(i, "exists", false)
      workspaceModel.setProperty(i, "active", false)
      workspaceModel.setProperty(i, "urgent", false)
      workspaceModel.setProperty(i, "special", false)
      workspaceModel.setProperty(i, "appRepTitle", "")
      workspaceModel.setProperty(i, "appRepIndex", -1)
      workspaceModel.setProperty(i, "appRepScore", 0)
      workspaceModel.setProperty(i, "appRepIcon", "")
      let model = workspaceModel.get(i).toplevels
      model.clear()
    }

    let maxId = Config.system.ui.minNumberOfPillShown

    for (let ws of root.workspaces.values) {
      let wsId = ws.id <= 0 ? 0 : ws.id
      if (wsId < 0 || wsId >= workspaceModel.count)
      continue

      let i = wsId
      workspaceModel.setProperty(i, "exists", true)
      workspaceModel.setProperty(i, "active", ws.active)
      workspaceModel.setProperty(i, "urgent", ws.urgent)
      if (wsId > root.maxWsId) {
        maxId = wsId > maxId ? wsId : maxId
      } else if (wsId < Config.system.ui.minNumberOfPillShown) {
        maxId = Config.system.ui.minNumberOfPillShown
      }
      if (root.maxWsId != maxId) {
        root.maxWsId = maxId
      }
    }
    function isStrictPathTitle(title) {
      if (!title)
      return false

      const t = title.trim()
      const re = /^(~\/|\/)[a-zA-Z0-9._\-\/]*$/

      return re.test(t)
    }

    function appScoreAndIcon(clazz, titlee) {
      const cls = (clazz || "").toLowerCase()
      const title = titlee || ""

      const isTerminal = cls in Icon.terminals

      let score = 0
      let icon = ""

      // non-terminal + recognized
      if (!isTerminal) {
        const [ priority, recognizedIcon ] = Icon.getRecognizedIconFromInitialClass(cls)
        if (recognizedIcon) {
          score += priority + 50
          icon = recognizedIcon
        }
      }
      // terminal + recognized
      else if (isTerminal) {
        const [ priority, recognizedIcon ] = Icon.getRecognizedIconFromTitle(title)
        if (recognizedIcon) {
          score += priority
          icon = recognizedIcon
        } else {
          icon = Icon.terminals.kitty
          score += 10
        }
      }
      // non-terminal unrecognized
      else {
        score += 1
        icon = ""
      }

      return { score, icon }
    }

    for (let toplevel of root.toplevels.values) {
      if(!toplevel.workspace?.id) {
        continue
      }
      let wsId = toplevel.workspace?.id <= 0 ? 0 : toplevel.workspace?.id
      if (wsId < 0 || wsId >= workspaceModel.count) continue

      let ws = workspaceModel.get(wsId)
      let wsToplevel = ws.toplevels
      let index = wsToplevel.count
      var o = toplevel.lastIpcObject

      wsToplevel.append({
        address: toplevel.address,
        pid: o.pid ?? 0 ,
        class: o.class ?? "",
        title: toplevel.title,
        initialTitle: o.initialTitle ?? "",
        activated: toplevel.activated,
        mapped: o.mapped ?? false,
        hidden: o.hidden ?? false,
        floating: o.floating ?? false,
        pinned: o.pinned ?? false,
        fullscreen: o.fullscreen ?? 0,
        x: o.at ? o.at[0] : 0,
        y: o.at ? o.at[1] : 0,
        width: o.size ? o.size[0] : 0,
        height: o.size ? o.size[1] : 0,
        workspaceId: wsId,
        workspaceName: toplevel.workspace.name,
        monitor: toplevel.monitor
      })


      const { score, icon } = appScoreAndIcon(o.initialClass, toplevel.title)


      if (score > ws.appRepScore) {
        ws.appRepTitle = toplevel.title
        ws.appRepIcon = icon
        ws.appRepIndex = index
        ws.appRepScore = score
      }

    }
  }


  Component.onCompleted: {
    workspaceModel.clear()

    for (let i = 0; i < Config.system.ui.maxNumberOfPillShown + 1; i++) {
      root.workspaceModel.append({
        wsId: i,
        exists: false,
        active: false,
        urgent: false,
        special: false,
        toplevels: [],
        appRepTitle: "",        
        appRepIcon: "",        
        appRepIndex: -1,     
        appRepScore: 0,      
      })
    }


    updateWorkspaceModel()
  }


}
