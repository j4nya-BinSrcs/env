-- ╭───────────────────────────────────────────────────────────────────────────────────────────────╮
-- │███████╗███╗   ██╗██╗   ██╗██╗██████╗  ██████╗ ███╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗│
-- │██╔════╝████╗  ██║██║   ██║██║██╔══██╗██╔═══██╗████╗  ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝│
-- │█████╗  ██╔██╗ ██║██║   ██║██║██████╔╝██║   ██║██╔██╗ ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   │
-- │██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██╔══██╗██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   │
-- │███████╗██║ ╚████║ ╚████╔╝ ██║██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   │
-- │╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   │
-- │                                            Janya's RICE                                       │
-- ╰───────────────────────────────────────────────────────────────────────────────────────────────╯
-- Configurations for the Devices and Monitors.
-- Documentation: https://wiki.hypr.land/configuring/core/devices/
-- ─────────────────────────────────────────────────────────────────────────────────────────────────


-- import the vars module.
local vars = require("modules.vars")

-- ─── Monitors ────────────────────────────────────────────────────────────────────────────────────
-- Default monitor configuration. Add more monitors if needed.
hl.monitor({
    output   = vars.monitors.primary,
    mode     = "preferred",
    position = "auto",
    scale    = vars.monitors.scale,
    transform = vars.monitors.transform
})

-- ─── Input ───────────────────────────────────────────────────────────────────────────────────────
-- Default Keyboard configuration.
hl.config({
    input = {
        kb_layout  = vars.input.layout,
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = vars.input.follow_mouse,

        sensitivity = vars.input.sensitivity, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = vars.input.natural_scroll,
        },
    },
})

-- ─── Other Devices ───────────────────────────────────────────────────────────────────────────────
-- Example device configuration.
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
