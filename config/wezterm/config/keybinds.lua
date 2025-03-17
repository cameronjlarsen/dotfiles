local wezterm = require("wezterm")
local catppuccin = require("colors.catppuccin")

return function(config)
    local colors = catppuccin.colors

    config.disable_default_key_bindings = false
    config.keys = {
        {
            mods = "ALT",
            key = [[\]],
            action = wezterm.action({
                SplitHorizontal = { domain = "CurrentPaneDomain" },
            }),
        },
        {
            mods = "ALT|SHIFT",
            key = [[|]],
            action = wezterm.action.SplitPane({
                top_level = true,
                direction = "Right",
                size = { Percent = 50 },
            }),
        },
        {
            mods = "ALT",
            key = [[-]],
            action = wezterm.action({
                SplitVertical = { domain = "CurrentPaneDomain" },
            }),
        },
        {
            mods = "ALT|SHIFT",
            key = [[_]],
            action = wezterm.action.SplitPane({
                top_level = true,
                direction = "Down",
                size = { Percent = 50 },
            }),
        },
        { key = "t",          mods = "CTRL|SHIFT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }), },
        { key = "w",          mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }), },
        { key = "q",          mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
        { key = "z",          mods = "ALT",        action = wezterm.action.TogglePaneZoomState },
        { key = "F11",        mods = "",           action = wezterm.action.ToggleFullScreen },
        { key = "h",          mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
        { key = "j",          mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },
        { key = "k",          mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
        { key = "l",          mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
        { key = "LeftArrow",  mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
        { key = "DownArrow",  mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },
        { key = "UpArrow",    mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
        { key = "RightArrow", mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
        { key = "h",          mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
        { key = "j",          mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
        { key = "k",          mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
        { key = "l",          mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
        { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
        { key = "DownArrow",  mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
        { key = "UpArrow",    mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
        { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
        { key = "[",          mods = "ALT",        action = wezterm.action({ ActivateTabRelative = -1 }) },
        { key = "]",          mods = "ALT",        action = wezterm.action({ ActivateTabRelative = 1 }) },
        { key = "{",          mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(-1) },
        { key = "}",          mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(1) },
        { key = "v",          mods = "ALT",        action = wezterm.action.ActivateCopyMode },
        { key = "c",          mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "v",          mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        { key = "=",          mods = "CTRL",       action = wezterm.action.IncreaseFontSize },
        { key = "-",          mods = "CTRL",       action = wezterm.action.DecreaseFontSize },
        -- Tab activation shortcuts
        { key = "1",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 1 }) },
        { key = "2",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 2 }) },
        { key = "3",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 3 }) },
        { key = "4",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 4 }) },
        { key = "5",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 5 }) },
        { key = "6",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 6 }) },
        { key = "7",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 7 }) },
        { key = "8",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 8 }) },
        { key = "9",          mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 9 }) },
        { key = "Enter",      mods = "ALT",        action = wezterm.action.DisableDefaultAssignment },

        -- Workspace management
        {
            key = 'i',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.PromptInputLine({
                description = wezterm.format({
                    { Attribute = { Intensity = 'Bold' } },
                    { Foreground = { Color = colors.pink } },
                    { Text = 'Enter name for new workspace' },
                }),
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:perform_action(
                            wezterm.action.SwitchToWorkspace({
                                name = line,
                            }),
                            pane
                        )
                    end
                end),
            }),
        },
        -- Workspace launcher with fuzzy finder
        {
            key = "w",
            mods = "ALT|SHIFT",
            action = wezterm.action.ShowLauncherArgs({
                flags = "FUZZY|WORKSPACES",
            }),
        },
        -- Workspace navigation
        { key = "n", mods = "CTRL", action = wezterm.action.SwitchWorkspaceRelative(1) },
        { key = "p", mods = "CTRL", action = wezterm.action.SwitchWorkspaceRelative(-1) },
    }

    return config
end

