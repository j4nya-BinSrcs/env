import QtQuick

// Reusable pill-style switch used for toggles.
Rectangle {
  id: root

  property bool checked: false
  property color onColor: Qt.rgba(0.48, 0.64, 0.97, 0.9)
  property color offColor: Qt.rgba(1, 1, 1, 0.2)
  signal toggled()

  width: 40
  height: 22
  radius: 11
  color: root.checked ? root.onColor : root.offColor
  Behavior on color { ColorAnimation { duration: 200 } }

  Rectangle {
    width: 16
    height: 16
    radius: 8
    color: "#ffffff"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: root.checked ? 22 : 3
    Behavior on anchors.leftMargin { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: root.toggled()
  }
}