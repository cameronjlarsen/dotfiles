local wezterm = require("wezterm")
local catppuccin = require("colors.catppuccin")

return function(config)
    -- Get colors from the catppuccin module
    local colors = catppuccin.colors

    wezterm.on("update-status", function(window, pane)
        local battery_info = {}
        for _, b in ipairs(wezterm.battery_info()) do
            table.insert(battery_info, string.format("%.0f%%", b.state_of_charge * 100))
        end
        local time = wezterm.strftime("%-l:%M %P")
        local background = window:effective_config().colors.tab_bar.background

        window:set_right_status(wezterm.format({
            { Background = { Color = background } },
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.ple_upper_right_triangle },
            { Background = { Color = colors.green } },
            { Foreground = { Color = background } },
            { Text = " " .. wezterm.nerdfonts.fa_male .. " " },
            { Text = wezterm.nerdfonts.ple_upper_right_triangle },
            { Background = { Color = background } },
            { Foreground = { Color = colors.text } },
            { Text = " " .. window:active_workspace() .. " " },
            { Background = { Color = background } },
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.ple_upper_right_triangle },
            { Background = { Color = colors.blue } },
            { Foreground = { Color = background } },
            { Text = " " .. wezterm.nerdfonts.md_calendar_clock .. " " },
            { Text = wezterm.nerdfonts.ple_upper_right_triangle },
            { Background = { Color = background } },
            { Foreground = { Color = colors.text } },
            { Text = " " .. time .. " " },
            { Background = { Color = background } },
            { Foreground = { Color = colors.text } },
            { Text = table.concat(battery_info, " ") },
        }))
    end)

    return config
end
