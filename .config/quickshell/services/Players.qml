pragma Singleton

import qs.configs
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import QtQml
import QtQuick

Singleton {
  id: root
  readonly property list<MprisPlayer> playerList: Mpris.players.values
  property MprisPlayer active: playerList[0] ?? null
  property var playHistory: []

  function pushPlaying(player) {
    let idx = root.playHistory.indexOf(player)
    if (idx !== -1)
      root.playHistory.splice(idx, 1)

    root.playHistory.unshift(player)
    active = root.playHistory[0]
  }

  function removePlaying(player) {
    let idx = root.playHistory.indexOf(player)
    if (idx !== -1)
      root.playHistory.splice(idx, 1)

    if (root.playHistory.length > 0)
      active = root.playHistory[0]
  }
  function initPlayHistory() {
    root.playHistory = []
    for (let p of playerList) {
      if (p.isPlaying)
        root.playHistory.push(p)
    }
    if (root.playHistory.length > 0)
      active = root.playHistory[0]
  }

  Item {
    id: conns
    property var connections: []
    Component {
      id: connectionsComponent

      Connections {
        property var src
        target: src

        function onPlaybackStateChanged() {
          if (src.isPlaying) {
            root.pushPlaying(src)
          } else {
            root.removePlaying(src)
          }
        }
      }
    }

    function createConnections() {
      for (let c of connections)
      c.destroy()
      connections = []

      for (let s of root.playerList) {
        let c = connectionsComponent.createObject(root, { src: s })
        connections.push(c)
      }
    }
  }
  onPlayerListChanged:{
    conns.createConnections()
    root.initPlayHistory()

  } 

  IpcHandler {
    target: "mpris"

    function getActive(prop: string): string {
      const active = root.active;
      return active ? active[prop] ?? "Invalid property" : "No active player";
    }

    function list(): string {
      for (const l of root.playerList) {
        console.info(l.identity)
      } 
      return root.playerList[0].identity;
    }

    function play(): void {
      const active = root.active;
      if (active?.canPlay)
          active.play();
    }

    function pause(): void {
      const active = root.active;
      if (active?.canPause)
          active.pause();
    }

    function playPause(): void {
      const active = root.active;
      if (active?.canTogglePlaying)
          active.togglePlaying();
    }

    function previous(): void {
      const active = root.active;
      if (active?.canGoPrevious)
          active.previous();
    }

    function next(): void {
      const active = root.active;
      if (active?.canGoNext)
          active.next();
    }

    function stop(): void {
      root.active?.stop();
    }
  }
}
