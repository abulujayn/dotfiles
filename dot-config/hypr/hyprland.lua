-- Do not embed a /nix/store path: find the defaults supplied by the installed
-- Hyprland package.  Set HYPRLAND_DEFAULT_CONFIG to override either location.
local defaults = os.getenv("HYPRLAND_DEFAULT_CONFIG")
  or "/usr/share/hypr/hyprland.lua"
local defaults_file = io.open(defaults, "r")
if defaults_file == nil then
  defaults = "/run/current-system/sw/share/hypr/hyprland.lua"
else
  defaults_file:close()
end

local packaged_bind = hl.bind
hl.bind = function() end
dofile(defaults)
hl.bind = packaged_bind

require("monitors")

hl.config({
  general = { layout = "scrolling", col = { active_border = "rgba(81a1c1ff)" } },
  scrolling = {
    column_width = 1.0,
    fullscreen_on_one_column = false,
    explicit_column_widths = "0.5, 1.0",
    follow_min_visible = 1.0,
  },
  decoration = { rounding = 0 },
  input = { touchpad = { natural_scroll = true } },
})

hl.window_rule({ name = "kitty_starting_width", match = { class = "kitty" }, scrolling_width = 0.5 })

local mainMod = "SUPER"
local noctalia = "noctalia msg "
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle maximized" })
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(noctalia .. "window-switcher"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(noctalia .. "settings-toggle"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(noctalia .. "session lock"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(noctalia .. "panel-toggle session"))
hl.bind("Print", hl.dsp.exec_cmd(noctalia .. "screenshot-annotate"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(noctalia .. "screenshot-fullscreen pick"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(noctalia .. "panel-toggle clipboard"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctalia .. "panel-toggle wallpaper"))

for _, key in ipairs({ "left", "H" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.layout("focus l"), { repeating = true })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.layout("swapcol l"), { repeating = true })
end
for _, key in ipairs({ "right", "L" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.layout("focus r"), { repeating = true })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.layout("swapcol r"), { repeating = true })
end
for _, key in ipairs({ "up", "K" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = "up" }), { repeating = true })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = "up" }), { repeating = true })
end
for _, key in ipairs({ "down", "J" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = "down" }), { repeating = true })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = "down" }), { repeating = true })
end
hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("colresize 0.5"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("colresize 1.0"))
hl.bind(mainMod .. " + minus", hl.dsp.layout("colresize -0.05"), { repeating = true })
hl.bind(mainMod .. " + equal", hl.dsp.layout("colresize +0.05"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.layout("fit active"))
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("consume_or_expel next"))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))
for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
for _, binding in ipairs({
  { "XF86AudioRaiseVolume", "volume-up" }, { "XF86AudioLowerVolume", "volume-down" },
  { "XF86AudioMute", "volume-mute" }, { "XF86AudioMicMute", "mic-mute" },
  { "XF86MonBrightnessUp", "brightness-up" }, { "XF86MonBrightnessDown", "brightness-down" },
}) do
  hl.bind(binding[1], hl.dsp.exec_cmd(noctalia .. binding[2]), { locked = true, repeating = true })
end
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(noctalia .. "panel-toggle session"), { locked = true, dont_inhibit = true, long_press = false, release = false })
hl.on("hyprland.start", function() hl.exec_cmd("noctalia") end)
