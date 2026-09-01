-- ╭───────────────────────────────────────────────────────────────────────────────────────────────╮
-- │███████╗███╗   ██╗██╗   ██╗██╗██████╗  ██████╗ ███╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗│
-- │██╔════╝████╗  ██║██║   ██║██║██╔══██╗██╔═══██╗████╗  ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝│
-- │█████╗  ██╔██╗ ██║██║   ██║██║██████╔╝██║   ██║██╔██╗ ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   │
-- │██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██╔══██╗██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   │
-- │███████╗██║ ╚████║ ╚████╔╝ ██║██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   │
-- │╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   │
-- │                                            Janya's RICE                                       │
-- ╰───────────────────────────────────────────────────────────────────────────────────────────────╯
-- Defines environment variables required by the desktop session.
-- Documentation: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- ─────────────────────────────────────────────────────────────────────────────────────────────────



-- ─── Cursors ─────────────────────────────────────────────────────────────────────────────────────
-- Set the cursor size and theme.
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ─── GUI Backend ─────────────────────────────────────────────────────────────────────────────────
-- Run SDL2 applications on Wayland.
-- Remove or set to x11 if games that provide older versions of SDL cause compatibility issues.
hl.env("SDL_VIDEODRIVER", "wayland")
-- Force Clutter applications to try and use the Wayland backend.
hl.env("CLUTTER_BACKEND", "wayland")

-- ─── GTK ─────────────────────────────────────────────────────────────────────────────────────────
-- Set a GTK theme manually or use nwg-look
hl.env("GTK_THEME", "Nord")
-- GTK: Use Wayland if available; if not, try X11 and then any other GDK backend.
hl.env("GDK_BACKEND", "wayland,x11,*")

-- ─── Qt ──────────────────────────────────────────────────────────────────────────────────────────
-- Prefer Wayland for Qt applications while retaining X11 fallback.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- Prevent Qt applications from drawing their own Wayland decorations.
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- ─── Electron ────────────────────────────────────────────────────────────────────────────────────
-- Prefer native Wayland when supported by Electron/CEF applications.
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- ─── Wayland ─────────────────────────────────────────────────────────────────────────────────────
-- Identify the current graphical session as Wayland.
hl.env("XDG_SESSION_TYPE", "wayland")

-- ─── Nvidia ──────────────────────────────────────────────────────────────────────────────────────
local function has_nvidia_working()
	local version = io.open("/proc/driver/nvidia/version", "r")
	if not version then
		return false
	end
	version:close()

	-- The module registers /proc as it comes up, so a driver that is still
	-- loading or on its way out is ruled out by its recorded state.
	local initstate = io.open("/sys/module/nvidia/initstate", "r")
	if not initstate then
		return true
	end

	local state = initstate:read("*l")
	initstate:close()

	return state == "live"
end
if has_nvidia_working() then
    -- Used by applications that support VA-API hardware acceleration.
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
	-- Force GLX applications to use NVIDIA's GLX implementation.
	hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
end

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
