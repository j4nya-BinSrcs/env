import QtQuick

// Minimal draggable slider. `value` is watched for external changes (so it can
// be bound to a controller); dragging uses an internal value and only reports
// the final value through the `committed` signal, so the host binding is kept.
Item {
  id: root

  property real value: 0.5
  property real from: 0
  property real to: 1
  property color accent: "#7aa2f7"
  property color textColor: "#ffffff"

  signal committed(real v)

  property bool dragging: false
  property real dragValue: 0
  readonly property real displayValue: root.dragging ? root.dragValue : root.value

  height: 24

  Rectangle {
    id: track
    height: 5
    radius: height / 2
    color: Qt.rgba(1, 1, 1, 0.16)
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
  }

  Rectangle {
    id: fill
    width: (root.displayValue - root.from) / (root.to - root.from) * track.width
    height: track.height
    radius: height / 2
    color: root.accent
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
  }

  Rectangle {
    id: knob
    width: 13
    height: 13
    radius: width / 2
    color: root.textColor
    anchors.verticalCenter: parent.verticalCenter
    x: fill.width + track.x - width / 2
  }

  MouseArea {
    id: drag
    anchors.fill: parent
    onPressed: root.setFromMouse(mouse.x)
    onPositionChanged: if (drag.pressed) root.setFromMouse(mouse.x)
    onReleased: {
      root.dragging = false
      root.committed(root.dragValue)
    }
  }

  function setFromMouse(mx) {
    root.dragging = true
    const norm = Math.max(0, Math.min(1, (mx - track.x) / track.width))
    root.dragValue = root.from + norm * (root.to - root.from)
  }
}