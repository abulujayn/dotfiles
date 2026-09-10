local last_profile = nil

local function apply_layout()
    local profile

    if hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000") and hl.get_monitor("desc:Dell Inc. DELL C2422HE 5W1XYG3") then
        profile = "home-office"
    else
        profile = "laptop"
    end

    if profile == last_profile then
        return
    end
    last_profile = profile

    if profile == "desk" then
        hl.monitor({
          output = "desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000",
          mode = "2560x1440@100",
          position = "3456x-250",
          scale = 1,
          cm = "srgb",
        })

        hl.monitor({
          output = "desc:Dell Inc. DELL C2422HE 5W1XYG3",
          mode = "1920x1080@60",
          position = "1536x0",
          scale = 1,
          cm = "srgb",
        })

        hl.monitor({
          output = "desc:BOE NS140WUM-L61",
          mode = "1920x1200@60",
          position = "6016x831",
          scale = 1.25,
          cm = "srgb",
        })

        hl.config({
          cursor = { default_monitor = "desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000" },
        })

    else
        hl.monitor({
            output = "eDP-1",
            mode = "1920x1200@60",
            position = "0x0",
            scale = 1.25,
            cm = "srgb",
        })
    end
end

local apply_timer = hl.timer(apply_layout, {
    timeout = 300,
    type = "oneshot",
})

apply_timer:set_enabled(false)

local function schedule_layout()
    apply_timer:set_enabled(false)
    apply_timer:set_enabled(true)
end

hl.on("hyprland.start", apply_layout)

hl.on("monitor.added", schedule_layout)
hl.on("monitor.removed", schedule_layout)
