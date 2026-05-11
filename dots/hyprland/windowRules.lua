hl.layer_rule({ match = { namespace = "launcher" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "wleave" }, blur = true, xray = true })
hl.layer_rule({ match = { namespace = "bar-.*" }, blur = true, xray = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, animation = "slide" })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true, order = -2 })
hl.layer_rule({ match = { namespace = "still" }, no_anim = true, order = -1 })
hl.window_rule({ match = { class = ".*stremio.*" }, render_unfocused = true, content = "video" })
hl.window_rule({ match = { content = "video" }, idle_inhibit = "fullscreen", no_vrr = true })
hl.window_rule({ match = { class = "atril" }, idle_inhibit = "focus" })
hl.window_rule({ match = { class = "foot" }, idle_inhibit = "fullscreen", no_vrr = true })
hl.window_rule({ match = { class = "org.gnome.Loupe" }, no_vrr = true })
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize fullscreenoutput" })
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

hl.window_rule({ match = { class = "rars-Launch", title = "RARS .*" }, tile = true })
hl.window_rule({ match = { class = "com-cburch-logisim-Main", title = ".*Logisim-evolution v.*" }, tile = true })

hl.window_rule({ match = { class = "steam", title = "Steam" }, tile = true })

for _, match in ipairs({
	{ class = "info.cemu.Cemu" },
	{ class = "org.eden_emu.eden" },
	{ class = "dev.eden_emu.eden" },
	{ class = "dolphin-emu" },
}) do
	hl.window_rule({ match = match, tag = "+game" })
end

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
hl.window_rule({
	match = { class = "org.kde.dolphin" },
	move = { "cursor_x-(window_w*0.5)", "cursor_y-(window_h*0.5)" },
})
hl.window_rule({ match = { class = "kitty" }, opacity = "0.8 0.8" })
hl.window_rule({ match = { float = true }, opacity = "0.95 0.98" })
hl.window_rule({
	match = { class = "librewolf" },
	opacity = "1.0 override 1.0 override 1.0 override",
})

for _, match in ipairs({
	{ class = "org.kde.dolphin" }, -- umu / proton xwayland set this
	{ class = "mpv" }, -- umu / proton xwayland set this
	{ class = "qt5ct" },
	{ class = "qt6ct" }, -- 32-bit source
	{ title = "Kvantum Manager" }, -- 64-bit source
	{ class = "nwg-look" }, -- native sdl games
	{ class = "org.pulseaudio.pavucontrol" }, -- momentum mod
}) do
	hl.window_rule({
		match = match,
		float = true,
		move = { "window_w * 0.4", "(monitor_h / 6) + 10" },
		size = { "monitor_w * 0.6", "monitor_h * 0.7" },
	})
end
hl.window_rule({ match = { tag = "game" }, content = "game", idle_inhibit = "fullscreen", immediate = true })
hl.window_rule({ match = { class = "footclient" }, tag = "+term" }) -- Add dynamic tag `term*`
hl.window_rule({ match = { class = "footclient" }, tag = "term" }) -- Toggle dynamic tag `term*`
hl.window_rule({ match = { tag = "cpp" }, tag = "+code" }) -- Add `code*` to windows tagged `cpp`
hl.window_rule({ match = { tag = "code" }, opacity = "0.95" }) -- Set opacity for tag `code` or `code*`
hl.window_rule({ match = { class = "librewolf" }, opacity = "1.0" }) -- `cpp`-tagged windows match both; last wins
hl.window_rule({ match = { class = "kitty" }, opacity = "0.97" }) -- Match `term*` only, not bare `term`
hl.window_rule({ match = { tag = "term" }, tag = "-code" }) -- Remove dynamic tag `code*` from `term`/`term*`
