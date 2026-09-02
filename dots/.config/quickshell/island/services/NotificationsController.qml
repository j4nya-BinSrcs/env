import Quickshell
import Quickshell.Io
import QtQuick

// Integrates with the already-running dunst daemon: polls its notification
// history for the control panel list, and toggles "do not disturb" via
// dunstctl's pause so popups are actually suppressed.
Item {
  id: root
  visible: false

  property bool dnd: false
  // [{ id, appName, summary, body }] newest first, capped at 5.
  property var recent: []

  function refresh() {
    historyProc.running = true
  }

  function toggleDnd() {
    root.dnd = !root.dnd
    if (root.dnd)
      root.recent = []
    Quickshell.execDetached(["dunstctl", "set-paused", root.dnd ? "true" : "false"])
  }

  function dismiss(n) {
    Quickshell.execDetached(["dunstctl", "history-rm", String(n.id)])
    root.recent = root.recent.filter(x => x.id !== n.id)
  }

  Process {
    id: historyProc
    command: ["dunstctl", "history"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        let parsed
        try {
          parsed = JSON.parse(this.text)
        } catch (e) {
          return
        }
        const stored = parsed && parsed.type === "aa{sv}" && parsed.data && parsed.data[0]
        if (!stored) return
        const items = stored.map(hit => {
          const field = name => {
            const f = hit[name]
            return f && f.data !== undefined ? String(f.data) : ""
          }
          return {
            id: Number(hit.id && hit.id.data),
            appName: field("appname"),
            summary: field("summary"),
            body: field("body")
          }
        })
        if (root.dnd) return
        root.recent = items.slice(0, 5)
      }
    }
  }

  Timer {
    interval: 2000
    repeat: true
    running: true
    onTriggered: root.refresh()
  }

  Component.onCompleted: root.refresh()
}