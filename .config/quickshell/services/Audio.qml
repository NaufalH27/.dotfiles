pragma Singleton
import QtQml
import Quickshell.Services.Pipewire
import Quickshell

Singleton {
  id: root
  property var devices: Pipewire.nodes
  property var isReady: Pipewire.ready
  readonly property PwNode activeSpeaker: Pipewire.defaultAudioSink
  readonly property PwNode activeMic: Pipewire.defaultAudioSource
  onDevicesChanged: {rebuild()}
  onIsReadyChanged: {rebuild()}
  onActiveMicChanged: rebuild()
  onActiveSpeakerChanged: {rebuild()}
  PwObjectTracker {
    id: speakers
    objects: []
  }
  PwObjectTracker {
    id: mics
    objects: []
  }

  readonly property alias speakers: speakers
  readonly property alias mics: mics

  function rebuild() {
    function syncById(targetArray, sourceArray) {
      const sourceIds = new Set(sourceArray.map(n => n.id))

      for (let i = targetArray.length - 1; i >= 0; i--) {
        if (!sourceIds.has(targetArray[i].id)) {
          targetArray.splice(i, 1)
        }
      }

      for (const src of sourceArray) {
        if (!targetArray.some(t => t.id === src.id)) {
          targetArray.push(src)
        }
      }
    }

    let micss = []
    let speakerss = []

    if (!Pipewire.ready || !devices)
      return

    for (const node of devices.values) {
      if (!node || !node.audio)
        continue

      if (node.isSink && !node.isStream) {
        speakerss.push(node)
      }
      else if (!node.isSink && !node.isStream) {
        micss.push(node)
      }
    }

    syncById(mics.objects, micss)
    syncById(speakers.objects, speakerss)
  }

  function name(node) {
    return node?.nickname || node?.description || node?.name || ""
  }

  function setSpeaker(node) {
    Pipewire.preferredDefaultAudioSink = node
  }

  function setMic(node) {
    Pipewire.preferredDefaultAudioSource = node
  }

}

