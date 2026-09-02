pragma Singleton
import Quickshell

// Shell settings: user-configurable, session-persistent options shared by
// multiple services/widgets.
Singleton {
  id: root

  // When true the clock renders 24-hour "HH:mm", otherwise 12-hour "hh:mm AM".
  property bool use24HourClock: false

  // The Qt date-time format string consumed by ClockService. Switches purely
  // on the toggle so 12-hour always shows an AM/PM marker.
  readonly property var clockFormat: use24HourClock ? "HH:mm" : "hh:mm AP"
}
