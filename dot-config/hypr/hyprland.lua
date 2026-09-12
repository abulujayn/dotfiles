hl.config({
  general = {
      layout = "scrolling",

      border_size = 2,
      gaps_in = 3,
      gaps_out = 9,
      col = {
          active_border = "rgba(81a1c1ff)"
      }
  },
  scrolling = {
    column_width = 0.5,
    fullscreen_on_one_column = false,
    explicit_column_widths = "0.33, 0.5, 1.0",
    follow_min_visible = 1.0,
  },
  decoration = {
      rounding = 0
  },
  input = {
      touchpad = {
          natural_scroll = true
      }
  },
  animations = {
      enabled = false,
  },
})

require("monitors")
require("keybinds")
require("windows")

hl.on("hyprland.start", function() hl.exec_cmd("noctalia") end)
