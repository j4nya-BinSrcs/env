import Quickshell
import Quickshell.Io
import QtQuick

// Screen backlight control via brightnessctl. The current level is polled so
// hardware/OS brightness keys keep the slider in sync.
Item {
  id: root
  visible: false

  // 0..1, follows the display brightness.
  property real level: 1.0

  function refresh() {
    readProc.running = true
  }

  function applyLevel(v) {
    root.level = v
    Quickshell.execDetached(["brightnessctl", "-q", "set", Math.round(v * 100) + "%"])
  }

  Process {
    id: readProc
    // brightnessctl -m prints: dev,class,current,percent,max
    command: ["brightnessctl", "-m"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        const line = this.text.trim().split("\n")[0]
        const parts = line.split(",")
        if (parts.length >= 4) {
          const pct = parseInt(parts[3], 10)
          if (!isNaN(pct))
            root.level = pct / 100
        }
      }
    }
  }

  Timer {
    interval: 3000
    repeat: true
    running: true
    onTriggered: root.refresh()
  }

  Component.onCompleted: root.refresh()
}