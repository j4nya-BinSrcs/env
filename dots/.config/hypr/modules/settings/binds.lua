-- ╭───────────────────────────────────────────────────────────────────────────────────────────────╮
-- │███████╗███╗   ██╗██╗   ██╗██╗██████╗  ██████╗ ███╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗│
-- │██╔════╝████╗  ██║██║   ██║██║██╔══██╗██╔═══██╗████╗  ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝│
-- │█████╗  ██╔██╗ ██║██║   ██║██║██████╔╝██║   ██║██╔██╗ ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   │
-- │██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██╔══██╗██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   │
-- │███████╗██║ ╚████║ ╚████╔╝ ██║██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   │
-- │╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   │
-- │                                            Janya's RICE                                       │
-- ╰───────────────────────────────────────────────────────────────────────────────────────────────╯
-- Declaration of Programs, Services and Options as variables to be used by Hyprland.
-- Documentation: https://wiki.hypr.land/configuring/naming-conventions/
-- ─────────────────────────────────────────────────────────────────────────────────────────────────


-- import vars module for variables and mainMod.
local vars = require("modules.vars")
local mod = vars.keys.mod

-- ─── Keybinds ────────────────────────────────────────────────────────────────────────────────────
-- exit hyprland.
hl.bind("CTRL+ALT+DELETE", hl.dsp.exec_cmd("wlogout"))
hl.bind(mod .. "+ESCAPE", hl.dsp.exec_cmd(vars.commands.logout))

-- terminate a program.
hl.bind(mod .. "+Q", hl.dsp.window.close())

-- launch programs.
hl.bind(mod .. "+RETURN", hl.dsp.exec_cmd(vars.commands.terminal))
hl.bind(mod .. "+E", hl.dsp.exec_cmd(vars.commands.explorer))
hl.bind(mod .. "+SPACE", hl.dsp.exec_cmd(vars.commands.laucher))
hl.bind(mod .. "+B", hl.dsp.exec_cmd(vars.commands.browser))
hl.bind(mod .. "+X", hl.dsp.exec_cmd(vars.commands.editor))

-- window toggles.
hl.bind(mod .. "+F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. "+W", hl.dsp.window.pseudo())
hl.bind(mod .. "+J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus.
hl.bind(mod .. "+left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. "+right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. "+up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. "+down", hl.dsp.focus({ direction = "down" }))

-- Workspaces.
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    -- Switch workspaces with mod + [0-9]
    hl.bind(mod .. "+" .. key, hl.dsp.focus({ workspace = i }))
    -- Move active window to a workspace with mod + SHIFT + [0-9]
    hl.bind(mod .. "+SHIFT+" .. key, hl.dsp.window.move({ workspace = i }))
end

-- special workspace (scratchpad)
hl.bind(mod .. "+S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. "+SHIFT+S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Multimedia keys.
-- Play / Pause media (Locked so it works on lockscreen)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Next / Previous track
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Volume control (Repeating so holding down continues changing volume, Locked for lockscreen)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })

-- Mute audio
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness control (Repeating for smooth transitions, Locked for lockscreen support)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true, locked = true })


-- ─── Mouse Actions ───────────────────────────────────────────────────────────────────────────────
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. "+mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. "+mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "+mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. "+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ─── Gestures ────────────────────────────────────────────────────────────────────────────────────
-- Touchpad gestures.
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
