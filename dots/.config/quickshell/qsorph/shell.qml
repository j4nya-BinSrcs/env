import Quickshell
import QtQuick

import "commons"
import "core"
import "services"
import "widgets"


Scope {
    id: root

    Component.onCompleted: {
      // Touch the service registry so services instantiate and any early load
      // errors surface immediately. Depends on ServiceManager.clock being the
      // canonical accessor.
      console.log("qsorph loaded, time:", ServiceManager.clock.timeString)
    }

    // The shell's single centerpiece: a floating pill that morphs with ShellState.mode.
    HostPill {}
}
