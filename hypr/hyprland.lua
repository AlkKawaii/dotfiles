-------------
-- Monitor --
-------------

hl.monitor({
  output = "", mode = "preferred", position = "auto", scale = 1
})

-----------------------
-- Program Variables --
-----------------------

local terminal = "kitty"
local fileManager = "dolphin"
local launcher = "pkill rofi || rofi -show combi"

---------------
-- Autostart --
---------------

hl.on("hyprland.start", function ()
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("waybar")
  hl.exec_cmd("wpaperd -d")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

---------------------------
-- Environment Variables --
---------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------
-- Permissions --
-----------------

-- TODO: ativar isso

---------------
-- The looks --
---------------

hl.config({
  general = {
    gaps_in = 10,
    gaps_out = 10,

    border_size = 1,
  },
  decoration = {
    rounding = 0,
    rounding_power = 0,

    active_opacity = 1.0,
    inactive_opacity = 0.95,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)"
    },

    blur = {
       enabled = true,
       size = 3,
       passes = 1,
       vibrancy = 0.1696
    }
  },
  animations = {
    enabled = true
  }
})

----------------
-- Animations --
----------------

---------------------
-- Layouts configs --
---------------------

hl.config({
  dwindle = {
    preserve_split = true
  }
})

----------
-- Misc --
----------

hl.config({
  misc = {
     force_default_wallpaper = 0,
     disable_hyprland_logo = true,
    disable_splash_rendering = true
  }
})

-----------
-- Input --
-----------
hl.config({
  input = {
     kb_layout = "br",
     kb_variant = "",
     kb_model   = "",
     kb_options = "",
     kb_rules   = "",

     numlock_by_default = true,
     follow_mouse = 1,
     sensitivity = 0,

     touchpad = {
       natural_scroll = true,
       scroll_factor = 1.1
     }
  }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
----------------------------
-- Windows and Workspaces --
----------------------------
local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Keybindings

local mainMod = "SUPER"

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("wpaperctl next")) -- Cycle Wallpaper

-- Screenshot

hl.bind("Print", hl.dsp.exec_cmd("sh -c 'REGION=$(slurp) || exit; grim -g \"$REGION\" - | tee >(wl-copy) > ~/Imagens/screenshots/Screenshot-$(date +%F_%H-%M-%S).png && dunstify \"Screenshot of the region taken\" -t 1000'"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy && wl-paste > ~/Imagens/screenshots/Screenshot-$(date +%F_%T).png && dunstify \"Screenshot of the whole screen taken\" -t 1000"))

-- TODO: fix zooooooooom

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "-1" }))

hl.bind(mainMod .. " + TAB",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
