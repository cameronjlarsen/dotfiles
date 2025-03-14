local wezterm = require("wezterm")

-- Process icon mapping table with icon characters only
local process_icons = {
    ["docker"] = wezterm.nerdfonts.linux_docker,
    ["docker-compose"] = wezterm.nerdfonts.linux_docker,
    ["nvim"] = wezterm.nerdfonts.linux_neovim,
    ["vim"] = wezterm.nerdfonts.dev_vim,
    ["node"] = wezterm.nerdfonts.md_hexagon,
    ["zsh"] = wezterm.nerdfonts.dev_terminal,
    ["wezterm"] = wezterm.nerdfonts.dev_terminal,
    ["bash"] = wezterm.nerdfonts.cod_terminal_bash,
    ["pwsh"] = wezterm.nerdfonts.cod_terminal_powershell,
    ["htop"] = wezterm.nerdfonts.md_chart_donut_variant,
    ["btop"] = wezterm.nerdfonts.md_chart_donut_variant,
    ["cargo"] = wezterm.nerdfonts.dev_rust,
    ["go"] = wezterm.nerdfonts.md_language_go,
    ["lazydocker"] = wezterm.nerdfonts.linux_docker,
    ["git"] = wezterm.nerdfonts.dev_git,
    ["lazygit"] = wezterm.nerdfonts.dev_git,
    ["lua"] = wezterm.nerdfonts.seti_lua,
    ["wget"] = wezterm.nerdfonts.md_arrow_down_box,
    ["curl"] = wezterm.nerdfonts.md_flattr,
    ["gh"] = wezterm.nerdfonts.dev_github_badge,
    ["yay"] = "󰮯",
    ["pacman"] = "󰮯",
    ["ruby"] = wezterm.nerdfonts.dev_ruby,
    ["python"] = wezterm.nerdfonts.dev_python,
    ["python3.10"] = wezterm.nerdfonts.dev_python,
    ["python3.11"] = wezterm.nerdfonts.dev_python,
    ["lf"] = wezterm.nerdfonts.custom_folder_open,
    ["dotnet"] = "󰪮 ",
    ["cp"] = wezterm.nerdfonts.cod_copy,
}

-- Function to get process icon for a tab
local function get_process_icon(tab)
    local process_name = tab.active_pane.foreground_process_name:gsub("(.*[/\\])(.*)", "%2")
    -- on windows, still need to remove the .exe
    process_name = process_name:gsub("(.*)(%.exe)$", "%1")

    -- Return the icon or a fallback text representation
    return process_icons[process_name] or string.format("[%s]", process_name)
end

local function get_current_working_dir(tab)
    local cwd_uri = tab.active_pane.current_working_dir
    if cwd_uri then
        local cwd = ""
        local username = os.getenv("USER")

        if type(cwd_uri) == "userdata" then
            cwd = cwd_uri.file_path
        else
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find("/")
            if slash then
                cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
                    return string.char(tonumber(hex, 16))
                end)
            end
        end

        cwd = string.format("%s", string.gsub(cwd, "(.*[/\\])(.*[^/\\])[/\\]?$", "%2"))

        if cwd == username then
            cwd = "~"
        elseif cwd == "/" then
            cwd = "/"
        end

        return cwd
    end
end

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end

    return get_current_working_dir(tab_info) or ""
end

return function(config)
    -- Tab formatting with consistent color scheme
    wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local background = config.colors.tab_bar.background
        local active_bg = config.colors.tab_bar.active_tab.bg_color
        local active_fg = config.colors.tab_bar.active_tab.fg_color
        local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
        local inactive_fg = config.colors.tab_bar.inactive_tab.fg_color
        local inactive_hover_bg = config.colors.tab_bar.inactive_tab_hover.bg_color
        local inactive_hover_fg = config.colors.tab_bar.inactive_tab_hover.fg_color

        -- Set colors based on tab state
        local tab_bg, tab_fg, end_bg, end_fg, icon_fg

        if tab.is_active then
            tab_bg = active_bg
            tab_fg = active_fg
            end_fg = active_bg
            end_bg = background
            icon_fg = active_fg -- Use the tab foreground color for icon
        elseif hover then
            tab_bg = inactive_hover_bg
            tab_fg = inactive_hover_fg
            end_fg = inactive_hover_bg
            end_bg = background
            icon_fg = inactive_hover_fg -- Use the tab foreground color for icon
        else
            tab_bg = inactive_bg
            tab_fg = inactive_fg
            end_fg = inactive_bg
            end_bg = background
            icon_fg = inactive_fg -- Use the tab foreground color for icon
        end

        local index = string.format(" %s ", tab.tab_index + 1)
        local title = tab_title(tab)
        local process_icon = get_process_icon(tab)
        local zoomed = ""
        if tab.active_pane.is_zoomed then
            zoomed = wezterm.nerdfonts.md_alpha_z_box
        end

        -- Create tab format with consistent colors
        return wezterm.format({
            { Background = { Color = end_bg } },
            { Foreground = { Color = end_fg } },
            { Text = " " .. wezterm.nerdfonts.ple_left_half_circle_thick },
            { Background = { Color = tab_bg } },
            { Foreground = { Color = tab_fg } },
            { Text = zoomed },
            { Background = { Color = tab_bg } },
            { Foreground = { Color = icon_fg } },
            { Text = " " .. process_icon .. " " }, -- Add padding around the icon
            { Background = { Color = tab_bg } },
            { Foreground = { Color = tab_fg } },
            { Attribute = { Intensity = "Half" } },
            { Text = index },
            "ResetAttributes",
            { Background = { Color = tab_bg } },
            { Foreground = { Color = tab_fg } },
            { Text = title },
            { Background = { Color = end_bg } },
            { Foreground = { Color = end_fg } },
            { Text = wezterm.nerdfonts.ple_right_half_circle_thick .. " " },
        })
    end)

    return config
end

