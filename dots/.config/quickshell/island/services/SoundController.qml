import Quickshell
import Quickshell.Io
import QtQuick

// Default audio sink volume (0-1) and mute state via wpctl (WirePlumber).
// The state is polled so volume keys / other clients stay in sync.
Item {
  id: root
  visible: false

  property real volume: 0
  property bool muted: false

  function refresh() {
    readProc.running = true
  }

  function setVolume(v) {
    root.volume = v
    Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", String(Number(v).toFixed(2))])
  }

  function toggleMute() {
    root.muted = !root.muted
    Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", root.muted ? "1" : "0"])
  }

  Process {
    id: readProc
    // wpctl prints e.g. "Volume: 0.55" or "Volume: 0.55 [MUTED]".
    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        const m = this.text.trim().match(/Volume:\s*([0-9.]+)(?:\s*\[(MUTED|UNMUTED)\])?/)
        if (!m) return
        const v = parseFloat(m[1])
        if (!isNaN(v))
          root.volume = v
        if (m[2])
          root.muted = m[2] === "MUTED"
      }
    }
  }

  Timer {
    interval: 1000
    repeat: true
    running: true
    onTriggered: root.refresh()
  }

  Component.onCompleted: root.refresh()
}