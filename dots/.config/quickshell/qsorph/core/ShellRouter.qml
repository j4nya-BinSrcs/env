pragma Singleton
import Quickshell
import QtQuick
import "../commons"

// ShellRouter: owns HOW a ShellState.mode maps to rendered content, and the
// navigation between modes.

// Division of responsibility:
//   - ShellState holds the *current* mode (the mutable source of truth).
//   - ShellRouter owns the *route table* (mode -> body file + height) and the
//     navigation API (show/hide/toggle). The HostPill asks ShellRouter "what
//     body and height for the current mode?" and never hardcodes a body.

// This keeps the pill decoupled from specific panels.
Singleton {
  id: root

  // ---- Mode identifiers ----------------------------------------------------
  readonly property string modeClock: "clock"
  readonly property string modeControl: "control"  // future: control center
  readonly property string modeNotify: "notify"    // future: notifications

  // The collapsed/idle mode the pill settles into.
  readonly property string defaultMode: modeClock

  // ---- Route table (mode -> body + dimensions) -----------------------------
  // Body files are resolved by the HostPill's Loader relative to the widgets
  // directory, so we return plain filenames. Heights are explicit per mode so
  // the capsule can grow from a slim pill into a taller panel.
  function sourceFor(mode) {
    switch (mode) {
    case modeControl: return "ClockWidget.qml" // placeholder until real panels
    case modeNotify:  return "ClockWidget.qml" // placeholder
    default:          return "ClockWidget.qml"
    }
  }

  function heightFor(mode) {
    return Theme.pillHeight
  }

  // ---- Navigation ----------------------------------------------------------
  // Switch to a mode; no-op if already active.
  function show(mode) {
    ShellState.mode = mode
  }

  // Return to the idle/collapsed mode.
  function hide() {
    ShellState.mode = defaultMode
  }

  // Collapsed => expanded / expanded => collapsed. v0.4 has a single real
  // mode, so this bounces between the idle pill and the (future) control mode.
  function toggle() {
    ShellState.mode = ShellState.mode === defaultMode ? modeControl : defaultMode
  }
}
