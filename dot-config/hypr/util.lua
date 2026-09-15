Default_workspaces = {}

function Unused_workspace()
    for workspaceNum = 1, 10 do
        if not hl.get_workspace(tostring(workspaceNum)) then
            return tostring(workspaceNum)
        end
    end
end

function Reload()
    hl.exec_cmd("hyprctl reload")
end
Reload_timer = hl.timer(Reload, {
    timeout = 300,
    type = "oneshot",
})
Reload_timer:set_enabled(false)
function Schedule_reload()
    Reload_timer:set_enabled(false)
    Reload_timer:set_enabled(true)
end
