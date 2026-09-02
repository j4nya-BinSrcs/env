import Quickshell.Networking
import QtQuick

// Wi-Fi radio state and the name of the current network, backed by
// Quickshell's NetworkManager integration.
Item {
  id: root
  visible: false

  readonly property bool enabled: Networking.wifiEnabled

  readonly property string ssid: {
    const devs = Networking.devices ? Networking.devices.values : []
    for (let i = 0; i < devs.length; ++i) {
      const d = devs[i]
      if (d.type !== DeviceType.Wifi || !d.networks)
        continue
      const nets = d.networks.values
      for (let j = 0; j < nets.length; ++j) {
        if (nets[j].connected)
          return nets[j].name || ""
      }
    }
    return ""
  }

  function toggle() {
    Networking.wifiEnabled = !root.enabled
  }
}