import QtQuick

// Drives the clock/date strings shown in the center of the island.
Item {
  id: root
  visible: false

  property string timeText: ""
  property string dateText: ""

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      const now = new Date()
      root.timeText = Qt.formatTime(now, "hh:mm")
      root.dateText = Qt.formatDate(now, "dddd, MMMM d")
    }
  }
}