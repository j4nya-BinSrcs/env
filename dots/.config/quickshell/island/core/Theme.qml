import QtQuick

// Shared design tokens: colors, fonts and island dimensions.
QtObject {
  id: root

  property color pillBg: "#000000"
  property real pillBgOpacity: 0.75
  property color textColor: "#ffffff"
  property color mutedColor: "#9a9aa0"
  property color accentColor: "#7aa2f7"
  property string fontFamily: "JetBrainsMono Nerd Font"

  property int collapsedWidth: 140
  property int collapsedHeight: 44
  property int expandedWidth: 760
  property int expandedHeight: 96

  // Size the island grows to when the control panel is open.
  property int controlWidth: 420
  property int controlHeight: 400

  property int cornerRadius: 22
}
