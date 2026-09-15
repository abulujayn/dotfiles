local last_profile = nil
local function apply_layout()
    if hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000") and hl.get_monitor("desc:Dell Inc. DELL C2422HE 5W1XYG3") then
        Display_profile = "home-office"
    else
        Display_profile = "laptop"
    end

    if Display_profile == last_profile then
        return
    end
    last_profile = Display_profile

    if Display_profile == "home-office" then
        local monitor = hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000").name
        hl.monitor({
            output = monitor,
            mode = "2560x1440@100",
            position = "3456x-250",
            scale = 1,
            cm = "srgb",
        })
        hl.workspace_rule({ workspace = "1", monitor = monitor, default = true, persistent = true })

        monitor = hl.get_monitor("desc:Invalid Vendor Codename - RTK 0x0000 0x01010101").name
        hl.monitor({
            output = monitor,
            mode = "2560x1600@144.00Hz",
            position = "4096x1190",
            scale = 1.67,
            cm = "srgb",
        })
        hl.workspace_rule({ workspace = "2", monitor = monitor, default = true, persistent = true })
        Default_workspaces[monitor] = "2"

        monitor = hl.get_monitor("desc:Dell Inc. DELL C2422HE 5W1XYG3").name
        hl.monitor({
            output = monitor,
            mode = "1920x1080@60",
            position = "1536x0",
            scale = 1,
            cm = "srgb",
        })
        hl.workspace_rule({ workspace = "3", monitor = monitor, default = true, persistent = true })
        Default_workspaces[monitor] = "3"

        monitor = "eDP-1"
        hl.monitor({
            output = monitor,
            mode = "1920x1200@60",
            position = "6016x831",
            scale = 1.5,
            cm = "srgb",
        })
        hl.workspace_rule({ workspace = "4", monitor = monitor, default = true, persistent = true })
        Default_workspaces[monitor] = "4"
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

hl.on("hyprland.start", apply_layout)
hl.on("config.reloaded", apply_layout)

hl.on("monitor.added", Schedule_reload)
hl.on("monitor.removed", Schedule_reload)
