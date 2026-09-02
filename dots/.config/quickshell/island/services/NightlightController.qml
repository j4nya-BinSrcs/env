import Quickshell
import QtQuick

// Nightlight (warm color temperature) via hyprsunset. Only one CTM manager may
// run at a time, so enabling kills any existing instance first and disabling
// just kills it (releasing the color matrix back to identity).
Item {
  id: root
  visible: false

  property bool on: false

  function toggle() {
    root.on = !root.on
    if (root.on)
      Quickshell.execDetached(["sh", "-c", "pkill -x hyprsunset; hyprsunset -t 4500"])
    else
      Quickshell.execDetached(["pkill", "-x", "hyprsunset"])
  }
}