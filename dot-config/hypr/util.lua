-- Workspaces
Default_workspaces = {}
Workspace_rules = {}

function Unused_workspace()
    for workspaceNum = 1, 10 do
        if not hl.get_workspace(tostring(workspaceNum)) then
            return tostring(workspaceNum)
        end
    end
end

function Reset_workspace_rules()
    for _, rule in ipairs(Workspace_rules) do
        rule.set_enabled(false)
    end
    Workspace_rules = {}
end
