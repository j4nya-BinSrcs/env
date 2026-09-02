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

  // The pill's current mode.
  property var mode: "clock"
}
