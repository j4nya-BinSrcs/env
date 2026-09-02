import QtQuick

import qs.ui.bar

// Center section: time, date and workspace pills, stacked vertically.
Column {
  id: root

  property var theme: null
  property var clock: null
  property var workspaces: null
  property bool extended: true

  spacing: root.extended ? 3 : 0
  Behavior on spacing { NumberAnimation { duration: 220 } }

  Text {
    anchors.horizontalCenter: parent.horizontalCenter
    text: root.clock.timeText
    color: root.theme.textColor
    font { family: root.theme.fontFamily; pixelSize: root.extended ? 25 : 18; weight: Font.Bold }
    Behavior on font.pixelSize { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
  }

  Text {
    id: dateTxt
    anchors.horizontalCenter: parent.horizontalCenter
    text: root.clock.dateText
    color: root.theme.mutedColor
    font { family: root.theme.fontFamily; pixelSize: 11 }
    opacity: root.extended ? 1 : 0
    visible: root.extended || dateTxt.opacity > 0
  }

  WorkspacesBar {
    anchors.horizontalCenter: parent.horizontalCenter
    workspaces: root.workspaces
    theme: root.theme
  }
}