pragma Singleton
import Quickshell
import QtQuick

// Time service: the single source of clock data for the whole shell.
Singleton {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  // Read-only textual representation of the current time.
  readonly property var timeString: Qt.formatDateTime(clock.date, "hh:mm AP")
}
