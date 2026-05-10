hl.layer_rule({ match = { namespace = "launcher" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "wleave" }, blur = true, xray = true })
hl.layer_rule({ match = { namespace = "bar-.*" }, blur = true, xray = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, animation = "slide" })
-- show `still` below `slurp`, but above notifications
-- used to freeze screen during selection screenshots
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true, order = -2 })
hl.layer_rule({ match = { namespace = "still" }, no_anim = true, order = -1 })

-- hyprland shows anr dialog when stremio is in another workspace, so render_unfocused 1
hl.window_rule({ match = { class = ".*stremio.*" }, render_unfocused = true, content = "video" })
-- no vrr on video content, like mpv
hl.window_rule({ match = { content = "video" }, idle_inhibit = "fullscreen", no_vrr = true })

hl.window_rule({ match = { class = "atril" }, idle_inhibit = "focus" })

-- oled flicker is annoying on some apps
hl.window_rule({ match = { class = "foot" }, idle_inhibit = "fullscreen", no_vrr = true })
hl.window_rule({ match = { class = "org.gnome.Loupe" }, no_vrr = true })

-- some apps, mostly games, are stupid and they fullscreen on the
-- wrong monitor. so just don't listen to them lol
-- also ignore maximize requests from apps. You'll probably like this.
-- some games, like cs2, request tearing by default. disable this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize fullscreenoutput" })

-- dialogs
hl.window_rule({ match = { class = "org.kde.dolphin" }, float = true })
hl.window_rule({ match = { class = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "qt5ct" }, float = true })
hl.window_rule({ match = { class = "qt6ct" }, float = true })
hl.window_rule({ match = { title = "Kvantum Manager" }, float = true })
hl.window_rule({ match = { title = "File Operation Progress.*" }, float = true })
hl.window_rule({ match = { title = "Confirm to replace files.*" }, float = true })
hl.window_rule({ match = { title = "Select a File.*" }, float = true })
hl.window_rule({ match = { title = "Save As.*" }, float = true })
hl.window_rule({ match = { title = "Rename.*" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-kde" }, float = true })
hl.window_rule({ match = { class = "org.gnome.FileRoller", title = "Extract.*" }, float = true })

-- make some java apps launch tiled
hl.window_rule({ match = { class = "rars-Launch", title = "RARS .*" }, tile = true })
hl.window_rule({ match = { class = "com-cburch-logisim-Main", title = ".*Logisim-evolution v.*" }, tile = true })

-- see: https://github.com/hyprwm/Hyprland/discussions/12786
hl.window_rule({ match = { class = "steam", title = "Steam" }, tile = true })

-- Window rules for games
-- emulators and similar apps that should be tagged as games, but not forced fullscreen
for _, match in ipairs({
	{ class = "info.cemu.Cemu" },
	{ class = "org.eden_emu.eden" },
	{ class = "dev.eden_emu.eden" },
	{ class = "dolphin-emu" },
}) do
	hl.window_rule({ match = match, tag = "+game" })
end

-- wine/proton/native titles that should launch fullscreen
for _, match in ipairs({
	{ xdg_tag = "proton-game" }, -- proton w/ wine-wayland sets this
	{ class = "steam_app_.*" }, -- umu / proton xwayland set this
	{ class = "com.libretro.RetroArch" },
	{ class = ".*_linux" }, -- 32-bit source
	{ class = ".*_linux64" }, -- 64-bit source
	{ class = ".*.x86_64" }, -- native sdl games
	{ class = "momentum" }, -- momentum mod
	{ class = "cs2" },
	{ class = "org-prismlauncher-EntryPoint" }, -- legacy mc
	{ initial_title = "Minecraft\\* .*" }, -- mc up to v26.1
	{ initial_title = "Minecraft .*" }, -- v26.2+ mc
	{ class = "osu!" },
	{ class = "gamescope" },
	{ class = "Celeste" },
	{ class = "sm64coopdx" },
	{ class = "UnleashedRecomp" },
	{ class = "sober" },
	{ class = "waywall" },
	{ class = "love", title = "Freesync test" },
}) do
	hl.window_rule({ match = match, tag = "+game", fullscreen = true })
end

-- apply behavior by tag
hl.window_rule({ match = { tag = "game" }, content = "game", idle_inhibit = "fullscreen", immediate = true })
