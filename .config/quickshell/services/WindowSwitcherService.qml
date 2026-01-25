pragma Singleton
import QtQml
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property bool isActive: false
  property int selectorIndex: -1
  property int maxVisible: 11

  ListModel { id: allWindowsModel }
  ListModel { id: visibleWindowsModel }

  property alias allWindows: allWindowsModel
  property alias visibleWindows: visibleWindowsModel

  function getTitle() {
    if (root.selectorIndex < 0) return ""
    return root.allWindows.get(root.selectorIndex)?.window.title ?? ""
  }
  Process {
    id: launcher
  }

  function selectFocus() {
    const w = root.allWindows.get(root.selectorIndex)?.window
    root.isActive = false
    if (!w) return

    if (w.minimized) {
      Hypr.dispatch(`movetoworkspacesilent ${Hypr.activeWsId}, address:${w.address}`)
    }

    if (w.fullscreen > 0) {
      console.info(w.address)
      console.info(w.fullscreen)
      launcher.exec(["hyprctl", "--batch", `dispatch focuswindow address:${w.address}; dispatch fullscreen ${w.fullscreen} ; dispatch fullscreen ${w.fullscreen}`])
    } else {
      launcher.exec(["hyprctl", "dispatch", "focuswindow", `address:${w.address}`])
    }
  }
  function cycleNext() {
    if (root.allWindows.count <= 1) return
    root.selectorIndex = (root.selectorIndex + 1) % root.allWindows.count
    rebuildVisible()
  }

  function cyclePrev() {
    if (root.allWindows.count <= 1) return
    root.selectorIndex = (root.selectorIndex - 1 + root.allWindows.count) % root.allWindows.count
    rebuildVisible()
  }

  function deactivate() {
    root.isActive = false
    root.selectorIndex = -1
    root.allWindows.clear()
    root.visibleWindows.clear()
  }

  function rebuildVisible() {
    root.visibleWindows.clear()

    const total = root.allWindows.count
    if (total === 0) return

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

    for (let i = start; i < end; i++) {
      const item = root.allWindows.get(i)
      root.visibleWindows.append(item)
    }
  }

  IpcHandler {
    id: ipc
    target: "windowSwitcher"


    function activate() {
      if (root.isActive)
      return

      root.allWindows.clear()

      const toplevels = Hypr.workspaceModel.get(Hypr.activeWsId - 1)?.toplevels
      if (!toplevels)
      return

      const snapshot = []
      for (let i = 0; i < toplevels.count; i++) {
        const win = toplevels.get(i)
        if (!win) continue
        snapshot.push(win)
      }

      for (let i = 0; i < snapshot.length; i++) {
        root.allWindows.append({
          window: snapshot[i],
          globalIndex: i
        })
      }
      const count = root.allWindows.count
      if (count === 0) {
        root.selectorIndex = -1   
      } else if (count === 1) {
        root.selectorIndex = 0
      } else {
        root.selectorIndex = 1
      }
      root.rebuildVisible()
      root.isActive = true
    }
    function deactivate() {
      root.deactivate()
    }

  }
}

