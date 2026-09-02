pragma Singleton
import Quickshell
import QtQuick

import "../core"

// Service registry / lifecycle owner.
//
// Every service in the shell is a singleton declared in the services module
// and referenced here by bare name. Referencing the singleton types forces
// their single instantiation, and gives the whole shell one obvious point of
// entry for dependency resolution: UI and controllers pull services from
// ServiceManager, never construct their own.
//
// Each service keeps a Quickshell integration (SystemClock, Pipewire, Mpris,
// Hyprland, ...) isolated behind a small focused API so the UI layers never
// touch Quickshell service objects directly.
Singleton {
  id: root

  // Shell-level configuration (12/24h clock, later theme/behavior). Cross-
  // cutting, so it lives in core but is routed through here for a single
  // consumption surface.
  readonly property var settings: ShellSettings

  // Convenience accessors. Services are also reachable by bare name from any
  // file that imports the `services` module, but exposing them here keeps the
  // dependency graph explicit.
  readonly property var clock: ClockService
}
