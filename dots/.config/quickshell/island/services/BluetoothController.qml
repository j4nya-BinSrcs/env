import Quickshell.Bluetooth
import QtQuick

// Bluetooth adapter power state via BlueZ. Only exposes on/off; the discovery
// and pairing flows are left to the system's Bluetooth UI.
Item {
  id: root
  visible: false

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property bool enabled: root.adapter ? root.adapter.enabled : false

  readonly property int connectedCount: {
    let n = 0
    if (Bluetooth.devices) {
      const devs = Bluetooth.devices.values
      for (let i = 0; i < devs.length; ++i) {
        if (devs[i].connected)
          ++n
      }
    }
    return n
  }

  function toggle() {
    if (root.adapter) root.adapter.enabled = !root.enabled
  }
}