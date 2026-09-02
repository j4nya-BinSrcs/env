import Quickshell.Io
import QtQuick

// "Caffeine": while on, keeps the system from sleeping using systemd-inhibit.
Item {
  id: root
  visible: false

  property bool on: false

  function toggle() {
    root.on = !root.on
  }

  Process {
    id: proc
    command: ["systemd-inhibit", "--what", "sleep", "--mode", "block", "sleep", "infinity"]
    running: root.on
  }
}