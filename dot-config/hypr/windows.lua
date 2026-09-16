-- Full-width apps
hl.window_rule({
    match = {
        class = "org.keepassxc.KeePassXC|virt-viewer",
    },
    scrolling_width = 1.0,
})

-- Windows VM
hl.on("window.title", function(w)
    if not w or w.class ~= "virt-viewer" or (w.title ~= "windows (1)" and w.title ~= "windows (2)") then
        return
    end

    for _, tag in ipairs(w.tags) do
        if tag == "winvm" then
            return
        end
    end

    if w.title == "windows (1)" then
        local workspace = Unused_workspace()
        local monitor = "eDP-1"
        if Display_profile == "home-office" then
            monitor = hl.get_monitor("desc:KOGAN AUSTRALIA PTY LTD KAMN32RT1SA 0000000000000").name
        end
        hl.workspace_rule({
            workspace = workspace,
            monitor = monitor,
        })
        hl.dispatch(hl.dsp.window.move({
            window = w,
            workspace = workspace,
        }))
    elseif w.title == "windows (2)" then
        local workspace = Unused_workspace()
        local monitor = "eDP-1"
        if Display_profile == "home-office" then
            monitor = hl.get_monitor("desc:Dell Inc. DELL C2422HE 5W1XYG3").name
        end
        hl.workspace_rule({
            workspace = workspace,
            monitor = monitor,
        })
        hl.dispatch(hl.dsp.window.move({
            window = w,
            workspace = workspace,
        }))
    end

    hl.dispatch(hl.dsp.window.tag({
        window = w,
        tag = "+winvm"
    }))
end)
hl.on("window.close", function(w)
    local winvm = false
    for _, tag in ipairs(w.tags) do
        if tag == "winvm" then
            winvm = true
        end
    end
    if not winvm then
        return
    end

    Schedule_reload()
end)

-- Auto return to default workspace
hl.on("window.close", function(w)
    if #hl.get_windows({ workspace = w.workspace }) == 1 then
        local default_workspace = Default_workspaces[w.monitor.name] or "1"
        local current_monitor = hl.get_active_monitor().name
        hl.dispatch(hl.dsp.focus({ workspace = default_workspace }))
        if current_monitor ~= w.monitor.name then
            hl.dispatch(hl.dsp.focus({ monitor = current_monitor }))
        end
    end
end)
