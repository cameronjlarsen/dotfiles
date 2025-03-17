return function(config)
    config.term = "xterm-256color"
    config.default_prog = { "pwsh.exe, -nologo" }
    config.launch_menu = {}
    table.insert(config.launch_menu, { label = "pwsh", args = { "pwsh.exe", "-nologo" } })
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

    return config
end
