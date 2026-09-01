-- ╭───────────────────────────────────────────────────────────────────────────────────────────────╮
-- │███████╗███╗   ██╗██╗   ██╗██╗██████╗  ██████╗ ███╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗│
-- │██╔════╝████╗  ██║██║   ██║██║██╔══██╗██╔═══██╗████╗  ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝│
-- │█████╗  ██╔██╗ ██║██║   ██║██║██████╔╝██║   ██║██╔██╗ ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   │
-- │██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██╔══██╗██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   │
-- │███████╗██║ ╚████║ ╚████╔╝ ██║██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   │
-- │╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   │
-- │                                            Janya's RICE                                       │
-- ╰───────────────────────────────────────────────────────────────────────────────────────────────╯
-- Main Hyprland Configuration Entrypoint. All configuration is delegated to a dedicated lua module.
-- Documentation: https://wiki.hypr.land/
-- ─────────────────────────────────────────────────────────────────────────────────────────────────


-- module defining the required hyprland environment variables.
require("modules.core.env")

-- module declaring the hyprland permissions.
require("modules.core.perms")

-- module mentioning the input devices to the system.
require("modules.core.devices")

--module defining all the prorgams and services aliases.
require("modules.settings.programs")

-- module designing the layouts, window & workspaces rules, etc.
require("modules.settings.layouts")

-- module defining the look & feel, animations, etc.
require("modules.settings.visuals")

-- module assigning appropriate keybinds, mouse actions and trackpad motions for hyprland.
require("modules.settings.binds")

-- module mentioning programs and services to autostart on boot.
require("modules.settings.startup")
