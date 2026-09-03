import QtQuick
import "../commons"
import "../services"
import "../core"

// The clock BODY shown inside the HostPill. A single widget that adapts to the
// pill's ShellState.state rather than spawning per-state widgets:
//   idle     -> just the time (collapsed pill)
//   expanded -> larger time with the date/day below
//
// It reads ShellState.state directly and reports an implicitWidth that the
// HostPill capsule grows to fit. The capsule height is routed by
// ShellRouter.heightFor (52 idle, 96 expanded).

Item {
    id: root

    implicitWidth: Math.max(timeLine.implicitWidth, dateLine.implicitWidth)

    Column {
        id: col

        anchors.centerIn: parent
        spacing: Theme.gapXs

        Text {
          id: timeLine
          anchors.horizontalCenter: parent.horizontalCenter
          text: ServiceManager.clock.timeString
          color: Theme.fg
          font.family: Theme.fontFamily
          font.pixelSize: ShellState.state === ShellRouter.stateExpanded ? Theme.fontSizeLg : Theme.fontSizeMd
          font.weight: Font.Medium
        }

        Text {
          id: dateLine
          anchors.horizontalCenter: parent.horizontalCenter
          text: ServiceManager.clock.dateString
          color: Theme.fgMuted
          font.family: Theme.fontFamily
          font.pixelSize: Theme.fontSizeSm
          // Only the expanded surface shows the date; hiding its height keeps the
          // idle pill a single line.
          visible: ShellState.state === ShellState.stateExpanded
        }

    }
}
