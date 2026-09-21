Default_workspaces = {}
Workspace_rules = {}

function Unused_workspace()
    for workspaceNum = #Workspace_rules + 1, 10 do
        if not hl.get_workspace(tostring(workspaceNum)) then
            return tostring(workspaceNum)
        end
    end
end

function Reset_workspace_rules()
    for _, rule in ipairs(Workspace_rules) do
        rule:set_enabled(false)
    end
    Workspace_rules = {}
end

function Apply_workspace_rules()
    local monitor
    if Display_profile == "home-office" then
        monitor = "eDP-1"
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "4", monitor = monitor, default = true }))
        Default_workspaces[monitor] = "4"

        monitor = hl.get_monitor("desc:Dell Inc. DELL C2422HE 5W1XYG3").name
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "3", monitor = monitor, default = true }))
        Default_workspaces[monitor] = "3"

        monitor = hl.get_monitor("desc:Invalid Vendor Codename - RTK 0x0000 0x01010101").name
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "2", monitor = monitor, default = true }))
        Default_workspaces[monitor] = "2"

        monitor = hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000").name
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "1", monitor = monitor, default = true }))
    elseif Display_profile == "dual-monitor" then
        monitor = "eDP-1"
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "2", monitor = monitor, default = true }))
        Default_workspaces[monitor] = "2"

        monitor = hl.get_monitor("desc:Invalid Vendor Codename - RTK 0x0000 0x01010101").name
        table.insert(Workspace_rules, hl.workspace_rule({ workspace = "1", monitor = monitor, default = true }))
    else
        hl.monitor({
            output = "eDP-1",
            position = "0x0",
            scale = 1.25,
            cm = "srgb",
        })
    end
end

function Move_to_workspace(workspace)
    local w = hl.get_active_window()

    if not w then
        return
    end

    if w.floating then
        hl.dispatch(hl.dsp.window.move({
            workspace = workspace
        }))
        return
    end

    local width = w.layout.column.width
    hl.dispatch(hl.dsp.window.move({
        workspace = workspace
    }))
    hl.dispatch(
        hl.dsp.layout("colresize " .. width)
    )
end
