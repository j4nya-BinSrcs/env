import Quickshell
import QtQuick

import "commons"
import "core"
import "services"
import "widgets"

// Root scope. Non-visual; instantiates the global services and one HostPill
// per monitor so the pill floats on every screen.
Scope {
    id: root

    Component.onCompleted: {
      // Touch the service registry so services instantiate and any early load
      // errors surface immediately. Depends on ServiceManager.clock being the
      // canonical accessor.
      console.log("qsorph loaded, time:", ServiceManager.clock.timeString)
    }


    // One floating morphing capsule per screen. Variants assigns each HostPill
    // its own monitor via the window `screen` context, so anchors place the
    // pill at the top-center of every display.
    Variants {
        model: Quickshell.screens
        HostPill {}
    }
}
