import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQml.Models

import qs.core
import qs.models
import qs.services
import qs.ui.bar

// Status-bar "dynamic island" shell. This file only wires up the window, the
// pill, and the individual controller/visual modules; all logic lives in the
// imported component files.
PanelWindow {
  id: root

  // Fixed-size overlay so the window itself never resizes (no stutter).
  // The inner pill rectangle animates within it instead.
  anchors.top: true
  margins.top: 4
  // Only reserve the collapsed bar's height so the expanded island and the
  // control panel overlay tiled windows instead of pushing them down.
  exclusiveZone: theme.collapsedHeight - 4
  exclusionMode: ExclusionMode.Ignore
  color: "transparent"

  // The window grows when the control panel is open; otherwise it stays the
  // expanded size and the pill animates within it.
  implicitWidth: root.controlOpen ? theme.controlWidth : theme.expandedWidth
  implicitHeight: root.controlOpen ? theme.controlHeight : theme.expandedHeight

  // ----------------------------------------------------------------- modules
  Theme { id: theme }

  Clock { id: clock }
  MediaController { id: mediaCtrl }
  BatteryController { id: batteryCtrl }
  CaffeineController { id: caffeineCtrl }
  WorkspacesController { id: workspacesCtrl }
  WifiController { id: wifiCtrl }
  BluetoothController { id: btCtrl }
  SoundController { id: soundCtrl }
  BacklightController { id: backlightCtrl }
  NightlightController { id: nightlightCtrl }
  NotificationsController { id: notifCtrl }

  // ------------------------------------------------------- pill state
  // pinned keeps the island open even when the cursor leaves.
  property bool pinned: false
  property bool hovered: false
  // The island transforms into the full control panel while this is true.
  property bool controlOpen: false

  // The island shows its full content when hovering OR when pinned.
  readonly property bool extended: hovered || pinned

  readonly property real pillW: root.controlOpen
    ? theme.controlWidth - 4
    : (extended ? theme.expandedWidth - 4 : theme.collapsedWidth)
  readonly property real pillH: root.controlOpen
    ? theme.controlHeight - 8
    : (extended ? theme.expandedHeight - 4 : theme.collapsedHeight)

  // Whether the cursor is inside the currently-animated pill rect (window coords).
  function inCollapsedPill(x, y) {
    const w = root.pillW
    const h = root.pillH
    const px = (root.width - w) / 2
    return x >= px && x <= px + w && y >= 0 && y <= h
  }

  // ----------------------------------------------------------------- UI
  // Hover handling. The window is always the expanded size (no resizing) but
  // the island should only expand while hovering the collapsed pill itself.
  // A button-less hover sensor lets clicks pass through to the pill handlers.
  // Once extended, hover persists until the cursor leaves the window, so
  // moving near the edge of the expanded island doesn't make it flicker.
  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    onPositionChanged: function(mouse) {
      if (root.controlOpen) {
        root.hovered = true
        return
      }
      root.hovered = root.extended ? true : root.inCollapsedPill(mouse.x, mouse.y)
    }
    onExited: root.hovered = false
  }

  // The animated pill. Only this rectangle moves/resizes.
  Rectangle {
    id: pill
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    width: root.pillW
    height: root.pillH
    radius: theme.cornerRadius
    color: theme.pillBg
    opacity: theme.pillBgOpacity
    clip: true
    border.color: Qt.rgba(1, 1, 1, 0.08)

    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    // Click anywhere on the pill toggles the pinned state.
    MouseArea {
      anchors.fill: parent
      onClicked: root.pinned = !root.pinned
      propagateComposedEvents: false
    }

    // center: clock + date + workspaces
    CenterBox {
      anchors.centerIn: parent
      theme: theme
      clock: clock
      workspaces: workspacesCtrl
      extended: root.extended
      visible: !root.controlOpen
      opacity: visible ? 1 : 0
      Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
      }
    }

    // left: media player
    MediaBox {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 20
      media: mediaCtrl
      theme: theme
      extended: root.extended
      visible: root.extended && !root.controlOpen
      opacity: visible ? 1 : 0
      Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
      }
    }

    // right: control center (battery + caffeine)
    ControlCenter {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      anchors.rightMargin: 20
      theme: theme
      battery: batteryCtrl
      caffeine: caffeineCtrl
      extended: root.extended
      visible: root.extended && !root.controlOpen
      opacity: visible ? 1 : 0
      Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
      }

      onOpenPanel: {
        root.controlOpen = true
        root.pinned = true
      }
    }

    // the full control panel, shown when the island is in "control" mode
    ControlPanel {
      anchors.fill: parent
      theme: theme
      wifi: wifiCtrl
      bluetooth: btCtrl
      sound: soundCtrl
      backlight: backlightCtrl
      nightlight: nightlightCtrl
      battery: batteryCtrl
      caffeine: caffeineCtrl
      notifications: notifCtrl
      visible: root.controlOpen
      opacity: visible ? 1 : 0
      Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
      }

      onClosed: {
        root.controlOpen = false
        root.pinned = false
        root.hovered = false
      }
    }
  }
}
