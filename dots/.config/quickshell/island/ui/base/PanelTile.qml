import QtQuick

// A control-center tile: icon, label and status line, optionally acting as a
// toggle (highlighted when checked).
Rectangle {
  id: root

  property string icon: ""
  property string label: ""
  property string subtext: ""
  property bool toggleable: true
  property bool checked: false
  property var theme: null
  signal toggled()

  height: 58
  radius: 12
  color: root.checked
    ? Qt.rgba(theme.accentColor.r, theme.accentColor.g, theme.accentColor.b, 0.24)
    : Qt.rgba(1, 1, 1, 0.06)

  Behavior on color {
    ColorAnimation { duration: 150 }
  }

  Column {
    anchors.centerIn: parent
    spacing: 2

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.icon
      font { pixelSize: 15 }
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.label
      color: root.theme.textColor
      font { family: root.theme.fontFamily; pixelSize: 9; weight: Font.DemiBold }
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.subtext
      elide: Text.ElideRight
      color: root.theme.mutedColor
      font { family: root.theme.fontFamily; pixelSize: 8 }
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: if (root.toggleable) root.toggled()
  }
}