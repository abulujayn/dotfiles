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

    if profile == "home-office" then
        hl.monitor({
          output = "desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000",
          mode = "2560x1440@100",
          position = "3456x-250",
          scale = 1,
          cm = "srgb",
        })
        hl.workspace_rule({ workspace = "1", monitor = "desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000", default = true, persistent = true })

        hl.monitor({
          output = "desc:Dell Inc. DELL C2422HE 5W1XYG3",
          mode = "1920x1080@60",
          position = "1536x0",
          scale = 1,
          cm = "srgb",
        })
        hl.workspace_rule({ workspace = "2", monitor = "desc:Dell Inc. DELL C2422HE 5W1XYG3", default = true, persistent = true })

        hl.monitor({
          output = "desc:BOE NS140WUM-L61",
          mode = "1920x1200@60",
          position = "6016x831",
          scale = 1.25,
          cm = "srgb",
        })
        hl.workspace_rule({ workspace = "3", monitor = "desc:BOE NS140WUM-L61", default = true, persistent = true })

        hl.config({
          cursor = { default_monitor = hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000").name },
        })

        hl.timer(function()
            hl.dispatch(hl.dsp.focus({ workspace = "3" }))
            hl.dispatch(hl.dsp.focus({ workspace = "2" }))
            hl.dispatch(hl.dsp.focus({ workspace = "1" }))
        end, {
            timeout = 300,
            type = "oneshot",
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
