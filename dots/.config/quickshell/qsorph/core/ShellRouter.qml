pragma Singleton
import Quickshell
import QtQuick
import "../commons"

// ShellRouter: owns HOW a ShellState.state maps to rendered content and
// dimensions, plus the navigation between states.
//
// Division of responsibility:
//   - ShellState holds the *current* state (the mutable source of truth,
//     one of the identifiers below).
//   - ShellRouter owns the *route table* (state -> body file + height) and the
//     navigation API (show/hide/enter). The HostPill asks ShellRouter "what
//     body and height for the current state?" and never hardcodes a body.
//
// Predefined states (rather than ad-hoc mode names) keep the morph space
// bounded, so each surface — hover expansion, OSDs, panels — has one clear slot:
//   idle      collapsed clock pill (base/home)
//   expanded  taller pill on hover: time + date/day
//   osd       transient on-screen displays (volume/brightness/notifs, future)
//   panel     full control- + notification-center (future)
Singleton {
  id: root

  function sourceFor(state) {
    return "ClockWidget.qml"
  }

  function heightFor(state) {
    switch (state) {
    case ShellState.stateExpanded: return ShellState.expandedHeight
    default:                       return ShellState.idleHeight
    }
  }

  // ---- Navigation ----------------------------------------------------------
  function show(state) {
    ShellState.state = state
  }

  function hide() {
    ShellState.state = ShellState.defaultState
  }
}
