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


-- initialize a table to store all the variables.
local vars = {}

-- ─── Devices ─────────────────────────────────────────────────────────────────────────────────────
vars.monitors = {
    primary = "eDP-1",
    secondary = "HDMI-A-1",
    scale = 1.00,
    transform = 0,
}

vars.input = {
    layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
    natural_scroll = true
}

-- ─── Visuals ─────────────────────────────────────────────────────────────────────────────────────
-- https://wiki.hypr.land/Configuring/Basics/Variables/
vars.layout = [[Dwindle]]
vars.ui = {
    gaps = { inner = 4, outer = 12 },
    border = {
        size = 2,
        color = { active = "#232323aa", inactive = "#595959aa" },
        rounding = 15,
        rounding_power = 7,
    },
    opacity = { active = 0.95, inactive = 0.86 },
    shadow = {
        range = 82,
        render_power = 15,
        color = "0xee1a1a1a",
    },
    blur = {
       size = 12,
       passes = 3,
       vibrancy = 0.1696
   }
}

-- ─── Keys ────────────────────────────────────────────────────────────────────────────────────────
vars.keys = { mod = "SUPER"}

-- ─── Commands ────────────────────────────────────────────────────────────────────────────────────
-- commands including programs and services.
vars.commands = {
    terminal = "ghostty",
    explorer = "nautilus",
    laucher = "rofi -show run",
    browser = "zen-browser",
    editor = "zeditor",
    wallpaper_engine = "awww-daemon",
    shell = "qs",

    logout = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
}

-- ─── Scripts ─────────────────────────────────────────────────────────────────────────────────────
vars.scripts = {
-- To Be Added
}

-- ─── Paths ───────────────────────────────────────────────────────────────────────────────────────
vars.paths = {
-- To Be Added
}

return vars

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
