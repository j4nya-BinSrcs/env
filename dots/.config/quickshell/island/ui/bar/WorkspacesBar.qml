import QtQuick

// Horizontal strip of workspace pills with a traveling active indicator.
Item {
  id: root

  property var workspaces: null
  property var theme: null

  width: root.workspaces.rowW + 2 * root.workspaces.hPad
  height: root.workspaces.slotH + 10
  anchors.horizontalCenter: parent.horizontalCenter

  Rectangle {
    anchors.fill: parent
    radius: height / 2
    color: Qt.rgba(1, 1, 1, 0.06)
  }

  Row {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    spacing: root.workspaces.spacing
    Repeater {
      model: root.workspaces.ids
      Rectangle {
        required property int modelData
        width: root.workspaces.slotW
        height: root.workspaces.slotH
        radius: root.workspaces.slotH / 2
        color: Qt.rgba(1, 1, 1, 0.35)
        Behavior on color { ColorAnimation { duration: 200 } }
        MouseArea {
          anchors.fill: parent
          onClicked: root.workspaces.switchTo(modelData)
        }
      }
    }
  }

  // traveling active-workspace highlight (slides smoothly between slots)
  Rectangle {
    width: root.workspaces.slotW
    height: root.workspaces.slotH
    radius: root.workspaces.slotH / 2
    color: root.theme.accentColor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset: root.workspaces.travelX
    anchors.verticalCenter: parent.verticalCenter
    Behavior on anchors.horizontalCenterOffset {
      NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }
  }
}