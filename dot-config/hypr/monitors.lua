local last_profile = nil

local function setup_monitors()
    Reset_workspace_rules()

    if hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000") then
        Display_profile = "home-office"
    elseif hl.get_monitor("desc:Invalid Vendor Codename - RTK 0x0000 0x01010101") then
        Display_profile = "dual-monitor"
    else
        Display_profile = "laptop"
    end

    if Display_profile == last_profile then
        return
    end
    last_profile = Display_profile

    if Display_profile == "home-office" then
        hl.monitor({
            output = "eDP-1",
            position = "6016x831",
            scale = 1.5,
            cm = "srgb",
        })

        hl.monitor({
            output = "desc:Dell Inc. DELL C2422HE 5W1XYG3",
            position = "1536x0",
            scale = 1,
            cm = "srgb",
        })

        hl.monitor({
            output = "desc:Invalid Vendor Codename - RTK 0x0000 0x01010101",
            mode = "2560x1600@144.00Hz",
            position = "4096x1190",
            scale = 1.67,
            cm = "srgb",
        })

        hl.monitor({
            output = "desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000",
            position = "3456x-250",
            scale = 1,
            cm = "srgb",
        })
    elseif Display_profile == "dual-monitor" then
        hl.monitor({
            output = "desc:Invalid Vendor Codename - RTK 0x0000 0x01010101",
            mode = "2560x1600@144.00Hz",
            position = "0x0",
            scale = 1.67,
            cm = "srgb",
        })

        hl.monitor({
            output = "eDP-1",
            position = "128x960",
            scale = 1.25,
            cm = "srgb",
        })
    else
        hl.monitor({
            output = "eDP-1",
            position = "0x0",
            scale = 1.25,
            cm = "srgb",
        })
    end

    Apply_workspace_rules()
end

setup_monitors()
local timer = hl.timer(setup_monitors, {
    type = "oneshot",
    timeout = 300,
})
timer:set_enabled(false)
local function schedule_setup()
    timer:set_enabled(false)
    timer:set_enabled(true)
end

hl.on("monitor.added", schedule_setup)
hl.on("monitor.removed", schedule_setup)
