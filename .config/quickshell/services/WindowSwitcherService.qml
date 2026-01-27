pragma Singleton
import qs.utils
import QtQml
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property bool isActive: false
  property int selectorIndex: -1
  property int maxVisible: 11
  property string selectedTitle: ""

  function allWindows() {
    const ws = Hypr.workspaceModel.get(Hypr.activeWsId - 1)
    return ws ? ws.toplevels : null
  }

  property ListModel visibleWindows: ListModel {}
  onSelectorIndexChanged: updateVisibleWindows()

  function updateVisibleWindows() {
    visibleWindows.clear()

    const total = allWindows().count
    if (total === 0 || selectorIndex < 0)
      return

    root.selectedTitle = allWindows().get(selectorIndex)?.title ?? ""
    let start = root.selectorIndex - Math.floor(root.maxVisible / 2)
    let end = start + root.maxVisible

    if (start < 0) {
      start = 0
      end = root.maxVisible
    }
    if (end > total) {
      end = total
      start = Math.max(0, total - root.maxVisible)
    }

    for (let i = start; i <= end -1; i++) {
      let c = allWindows().get(i)
      if (!c) continue
      visibleWindows.append({
        window: c,
        realIndex: i
      })
    }
  }

  Process {
    id: launcher
  }

  function selectFocus() {
    let w = root.allWindows().get(root.selectorIndex)
    root.isActive = false
    if (!w) return
    launcher.exec(["sh", "-c", `${Paths.script}/scripts/focuswindow.sh ${w.address} ${w.fullscreen} ${w.minimized} ${Hypr.activeWsId}`])


    root.selectorIndex = -1
  }

  function cycleNext() {
    if (root.allWindows().count <= 1) return
    root.selectorIndex = (root.selectorIndex + 1) % root.allWindows().count
    updateVisibleWindows()
  }

  function cyclePrev() {
    if (root.allWindows().count <= 1) return
    root.selectorIndex = (root.selectorIndex - 1 + root.allWindows().count) % root.allWindows.count
    updateVisibleWindows()
  }

  function deactivate() {
    root.isActive = false
    root.selectorIndex = -1
  }

  IpcHandler {
    id: ipc
    target: "windowSwitcher"


    function activate() {
      if (root.isActive)
      return

      if(!root.allWindows()) return

      let count = root.allWindows().count
      if (count === 0) {
        root.selectorIndex = -1   
      } else if (count === 1) {
        root.selectorIndex = 0
      } else {
        root.selectorIndex = 1
      }
      root.isActive = true
      root.updateVisibleWindows()
    }

    function deactivate() {
      root.deactivate()
    }

  }
}

