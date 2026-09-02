import Quickshell.Services.UPower
import QtQuick

// Exposes aggregated battery percentage and charging state via UPower.
QtObject {
  id: root

  readonly property var device: findDevice()
  readonly property int percent: device
    ? Math.round(device.percentage * 100)
    : 100
  readonly property bool charging: device
    ? device.state === UPowerDeviceState.Charging || device.changeRate > 0
    : false

  function findDevice() {
    const list = UPower.devices ? UPower.devices.values : []
    for (let i = 0; i < list.length; ++i) {
      if (list[i].isLaptopBattery)
        return list[i]
    }
    return UPower.displayDevice
  }
}