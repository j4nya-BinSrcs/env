pragma Singleton
import Quickshell

// Shared, mutable UI state for the shell.
//
// This holds *presentation/intent* state (which mode the pill is in, hover,
// etc.) — NOT data source values, which belong to the services layer. The
// HostPill and its body widgets bind to this, so changing it dynamically
// morphs the pill anywhere in the shell. A singleton because exactly one
// session-wide intent exists.
Singleton {
  id: root

  // ---- State identifiers (the vocabulary) ----------------------------------
  readonly property string stateIdle: "idle"
  readonly property string stateExpanded: "expanded"
  readonly property string stateOsd: "osd"
  readonly property string statePanel: "panel"

  // The collapsed/home state the pill returns to when not interacted with.
  readonly property string defaultState: stateIdle

  // ---- State-associated dimensions -----------------------------------------
  // Dimensions tied to a particular state live here with the state model, not
  // in the router (which only maps/drives). Bodies and the HostPill read these
  // back so the sizing stays in sync with the state vocabulary.
  readonly property int idleHeight: 52      // collapsed pill height
  readonly property int expandedHeight: 96  // hover-expanded surface height

  // ---- Current state -------------------------------------------------------
  // The pill's current state; drives which body the HostPill renders and how
  // it is sized (see ShellRouter). Read/write: setting this morphs the pill.
  property string state: defaultState
}
