import Quickshell
import QtQuick

import "../commons"
import "../core"

// The HostPill: a single, self-contained floating capsule that is the center
// of the shell. Everything renders inside this pill and morphs based on
// ShellState.mode.

PanelWindow {
    id: root

    // Set by the Variants in shell.qml to this pill's screen info
    // (QuickshellScreenInfo). Consumed for per-monitor data; the window
    // placement itself is handled by Variants via the `screen` context.
    property var modelData

    anchors { top: true; left: true; right: true }
    exclusiveZone: 0
    aboveWindows: true
    implicitHeight: ShellRouter.heightFor(ShellState.mode) + Theme.pillTop * 2
    color: "transparent"


    // Only the capsule is interactive; everything else on this strip is click-through.
    mask: Region { item: capsule }

    // ---- The capsule --------------------------------------------------------
    Rectangle {
        id: capsule

        anchors.centerIn: parent

        // The capsule width is driven by the current body's desired width plus
        // horizontal padding, so it grows/shrinks as the content morphs.
        width: (capsuleBody.item ? capsuleBody.item.implicitWidth : 0) + Theme.pillPaddingX * 2
        // The height is routed per mode by ShellRouter (a slim pill or a taller
        // panel depending on the active content).
        height: ShellRouter.heightFor(ShellState.mode)

        radius: Theme.pillRadius
        color: mouse.containsMouse ? Theme.surface : Theme.bg
        border.color: Theme.border
        border.width: Theme.pillBorder
        opacity: mouse.containsMouse ? 1.0 : Theme.opacityInactive


        Behavior on color {
          ColorAnimation { duration: Theme.animMed; easing.type: Theme.easing }
        }
        Behavior on width {
          NumberAnimation { duration: Theme.animMed; easing.type: Theme.easing }
        }
        Behavior on height {
          NumberAnimation { duration: Theme.animMed; easing.type: Theme.easing }
        }
        Behavior on opacity {
          NumberAnimation { duration: Theme.animFast; easing.type: Theme.easing }
        }

        // ---- Morphing body ----------------------------------------------------
        // The active body loads lazily based on ShellState.mode, so only the
        // content in use is instantiated. The Loader sizes itself to the body's
        // implicit size (no anchors.fill, to avoid a width binding loop with the
        // capsule above) and stays centered in the pill.
        Loader {
          id: capsuleBody
          anchors.centerIn: parent
          source: ShellRouter.sourceFor(ShellState.mode)
        }
    }

    // ---- Hover + interaction ------------------------------------------------
    MouseArea {
      id: mouse
      anchors.fill: capsule
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
    }
}
