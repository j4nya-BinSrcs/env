import QtQuick
import "../commons"
import "../services"

// The clock BODY shown inside the HostPill in "clock" mode.
//
// Pure presentation: shows the time as a single line of text, reading the
// time string from ServiceManager.clock. It sizes itself to its content
// (implicit size); the HostPill centers it and owns the pill geometry.
Text {
  id: root

  text: ServiceManager.clock.timeString
  color: Theme.fg
  font.family: Theme.fontFamily
  font.pixelSize: Theme.fontSizeMd
  font.weight: Font.Medium
}
