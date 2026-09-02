import QtQuick
import QtQuick.Layouts

import qs.ui.base

// Right section: battery readout and caffeine (no-sleep) toggle.
RowLayout {
  id: root

  property var theme: null
  property var battery: null
  property var caffeine: null
  property bool extended: true
  signal openPanel()

  spacing: 10
  opacity: root.extended ? 1 : 0
  Behavior on opacity {
    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
  }

  // battery
  Column {
    Layout.alignment: Qt.AlignVCenter
    spacing: 3
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.battery.charging ? "🔌" : "🔋"
      color: root.theme.textColor
      font { family: root.theme.fontFamily; pixelSize: 15 }
    }
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.battery.percent + "%"
      color: root.theme.mutedColor
      font { family: root.theme.fontFamily; pixelSize: 10 }
    }
  }

  Rectangle {
    width: 1
    height: 40
    color: Qt.rgba(1, 1, 1, 0.12)
    Layout.alignment: Qt.AlignVCenter
  }

  // caffeine toggle
  Column {
    Layout.alignment: Qt.AlignVCenter
    spacing: 3
    ToggleSwitch {
      anchors.horizontalCenter: parent.horizontalCenter
      checked: root.caffeine.on
      onToggled: root.caffeine.toggle()
    }
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "☕"
      color: root.theme.mutedColor
      font { family: root.theme.fontFamily; pixelSize: 14 }
    }
  }

  Rectangle {
    width: 1
    height: 40
    color: Qt.rgba(1, 1, 1, 0.12)
    Layout.alignment: Qt.AlignVCenter
  }

  // opens the full control panel
  Rectangle {
    width: 30
    height: 30
    radius: 9
    color: Qt.rgba(1, 1, 1, 0.1)
    Layout.alignment: Qt.AlignVCenter
    Behavior on color {
      ColorAnimation { duration: 150 }
    }

    Text {
      anchors.centerIn: parent
      text: "☰"
      color: root.theme.textColor
      font { family: root.theme.fontFamily; pixelSize: 13 }
    }
    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onEntered: parent.color = Qt.rgba(1, 1, 1, 0.18)
      onExited: parent.color = Qt.rgba(1, 1, 1, 0.1)
      onClicked: root.openPanel()
    }
  }
}