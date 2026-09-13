local function assign_workspaces(monitor, first, last, persistent)
    for workspace = first, last do
        hl.workspace_rule({
            workspace = tostring(workspace),
            monitor = monitor,
            default = workspace == first,
            persistent = persistent,
        })
    end
end

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
        assign_workspaces("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000", 4, 6, true)

        hl.monitor({
          output = "desc:Dell Inc. DELL C2422HE 5W1XYG3",
          mode = "1920x1080@60",
          position = "1536x0",
          scale = 1,
          cm = "srgb",
        })
        hl.workspace_rule({ workspace = "2", monitor = "desc:Dell Inc. DELL C2422HE 5W1XYG3", default = true, persistent = true })
        assign_workspaces("desc:Dell Inc. DELL C2422HE 5W1XYG3", 7, 8, true)

        hl.monitor({
          output = "eDP-1",
          mode = "1920x1200@60",
          position = "6016x831",
          scale = 1.5,
          cm = "srgb",
        })
        hl.workspace_rule({ workspace = "3", monitor = "eDP-1", default = true, persistent = true })
        assign_workspaces("eDP-1", 9, 10, true)

        hl.config({
          cursor = { default_monitor = hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000").name },
        })

    else
        hl.monitor({
            output = "eDP-1",
            mode = "1920x1200@60",
            position = "0x0",
            scale = 1.25,
            cm = "srgb",
        })
        assign_workspaces("eDP-1", 1, 5, false)

        hl.config({
          cursor = { default_monitor = hl.get_monitor("eDP-1").name },
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
hl.on("config.reloaded", apply_layout)

hl.on("monitor.added", schedule_layout)
hl.on("monitor.removed", schedule_layout)
