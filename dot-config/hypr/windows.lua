-- Firefox
hl.window_rule({
    match = {
        class = "firefox",
    },
    scrolling_width = 1.0,
})

-- Windows VM
hl.on("window.title", function(w)
    if not w or w.class ~= "virt-viewer" or (w.title ~= "windows (1)" and w.title ~= "windows (2)") or w.fullscreen == 2 then
        return
    end

    for _, tag in ipairs(w.tags) do
        if tag == "windows-init" then
            return
        end
    end

    if w.title == "windows (1)" then
        hl.dispatch(hl.dsp.window.move({
            window = w,
            workspace = "4",
        }))
    elseif w.title == "windows (2)" then
        hl.dispatch(hl.dsp.window.move({
            window = w,
            workspace = "5",
        }))
    end

    hl.dispatch(hl.dsp.send_shortcut({
        window = w,
        mods = "",
        key = "F11",
    }))
    hl.dispatch(hl.dsp.window.tag({
        window = w,
        tag = "+windows-init"
    }))
end)
