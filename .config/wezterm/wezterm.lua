local wezterm = require("wezterm")
-- local hostname = wezterm.hostname()
local get_os = {
    ["x86_64-pc-windows-msvc"] = "Windows",
    ["x86_64-unknown-linux-gnu"] = "Linux",
    ["aarch64-unknown-linux-gnu"] = "Linux",
    ["aarch64-apple-darwin"] = "Darwin",
    ["x86_64-apple-darwin"] = "Darwin",
}

local function get_opacity(os)
    if os == "Darwin" then
        return 0.85
    else
        return 1
    end
end

local function enable_wayland()
    local wayland = os.getenv("XDG_SESSION_TYPE")
    if wayland == "wayland" then
        return true
    else
        return false
    end
end

local maple_font = {
    family = "MapleMono Nerd Font",
    harfbuzz_features = {
        "cv01", "cv03", "cv04", "ss01", "ss02", "ss03", "ss04"
    },
}

local function font_with_fallback(name, params)
    local names = { name, "JetBrainsMono Nerd Font", "Apple Color Emoji", "Noto Color Emoji", "Material Icons Rounded",
        "Symbols Nerd Font" }
    return wezterm.font_with_fallback(names, params)
end

local function is_vi_process(pane)
    return pane:get_user_vars().IS_NVIM == true
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
    if is_vi_process(pane) then
        window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
    else
        window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
    conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
    conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
    conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
    conditional_activate_pane(window, pane, "Down", "j")
end)

local colors = {
    rosewater = wezterm.color.parse("#f5e0dc"),
    flamingo  = wezterm.color.parse("#f2cdcd"),
    pink      = wezterm.color.parse("#f5c2e7"),
    mauve     = wezterm.color.parse("#cba6f7"),
    red       = wezterm.color.parse("#f38ba8"),
    maroon    = wezterm.color.parse("#eba0ac"),
    peach     = wezterm.color.parse("#fab387"),
    yellow    = wezterm.color.parse("#f9e2af"),
    green     = wezterm.color.parse("#a6e3a1"),
    teal      = wezterm.color.parse("#94e2d5"),
    sky       = wezterm.color.parse("#89dceb"),
    sapphire  = wezterm.color.parse("#74c7ec"),
    blue      = wezterm.color.parse("#89b4fa"),
    lavender  = wezterm.color.parse("#b4befe"),
    text      = wezterm.color.parse("#cdd6f4"),
    subtext1  = wezterm.color.parse("#bac2de"),
    subtext0  = wezterm.color.parse("#a6adc8"),
    overlay2  = wezterm.color.parse("#9399b2"),
    overlay1  = wezterm.color.parse("#7f849c"),
    overlay0  = wezterm.color.parse("#6c7086"),
    surface2  = wezterm.color.parse("#585b70"),
    surface1  = wezterm.color.parse("#45475a"),
    surface0  = wezterm.color.parse("#313244"),
    base      = wezterm.color.parse("#1e1e2e"),
    mantle    = wezterm.color.parse("#181825"),
    crust     = wezterm.color.parse("#11111b"),
}

local function get_process(tab)
    local process_icons = {
        ["docker"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["docker-compose"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["nvim"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.custom_vim },
        },
        ["vim"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.dev_vim },
        },
        ["node"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.md_hexagon },
        },
        ["zsh"] = {
            -- { Foreground = { Color = colors.base } },
            { Text = wezterm.nerdfonts.dev_terminal },
        },
        ["wezterm"] = {
            -- { Foreground = { Color = colors.base } },
            { Text = wezterm.nerdfonts.dev_terminal },
        },
        ["bash"] = {
            -- { Foreground = { Color = colors.base } },
            { Text = wezterm.nerdfonts.cod_terminal_bash },
        },
        ["pwsh"] = {
            -- { Foreground = { Color = colors.base } },
            { Text = wezterm.nerdfonts.cod_terminal_powershell },
        },
        ["htop"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.md_chart_donut_variant },
        },
        ["btop"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.md_chart_donut_variant },
        },
        ["cargo"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_rust },
        },
        ["go"] = {
            { Foreground = { Color = colors.sapphire } },
            { Text = wezterm.nerdfonts.md_language_go },
        },
        ["lazydocker"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["git"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lazygit"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lua"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.seti_lua },
        },
        ["wget"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.md_arrow_down_box },
        },
        ["curl"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.md_flattr },
        },
        ["gh"] = {
            { Foreground = { Color = colors.mauve } },
            { Text = wezterm.nerdfonts.dev_github_badge },
        },
        ["yay"] = {
            { Foreground = { Color = colors.blue } },
            { Text = "󰮯" },
        },
        ["pacman"] = {
            { Foreground = { Color = colors.blue } },
            { Text = "󰮯" },
        },
        ["ruby"] = {
            { Foreground = { Color = colors.red } },
            { Text = wezterm.nerdfonts.dev_ruby },
        },
        ["python"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.dev_python },
        },
        ["python3.10"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.dev_python },
        },
        ["python3.11"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.dev_python },
        },
        ["lf"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.custom_folder_open },
        },
        ["dotnet"] = {
            { Foreground = { Color = colors.mauve } },
            { Text = "󰪮 " },
        },
        ["cp"] = {
            { Foreground = { Color = '#00000000' } },
            { Text = wezterm.nerdfonts.cod_copy },
        },
    }

    local process_name = tab.active_pane.foreground_process_name:gsub("(.*[/\\])(.*)", "%2")
    -- on windows, still need to remove the .exe
    process_name = process_name:gsub("(.*)(%.exe)$", "%1")

    return wezterm.format(
        process_icons[process_name]
        or { { Foreground = { Color = colors.base } }, { Text = string.format("[%s]", process_name) } }
    )
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
        return string.format("%s %s", get_process(tab_info), title)
    end

    return string.format("%s %s", get_process(tab_info), get_current_working_dir(tab_info))
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = config.colors.tab_bar.background
    local active_bg = config.colors.tab_bar.active_tab.bg_color
    local active_fg = config.colors.tab_bar.active_tab.fg_color
    local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
    local inactive_fg = config.colors.tab_bar.inactive_tab.fg_color
    local inactive_hover_bg = config.colors.tab_bar.inactive_tab_hover.bg_color
    local inactive_hover_fg = config.colors.tab_bar.inactive_tab_hover.fg_color

    local sect_bg, sect_fg, end_bg, end_fg

    if tab.is_active then
        sect_bg = active_bg
        sect_fg = active_fg
        end_fg = active_bg
        end_bg = background
    elseif hover then
        sect_bg = inactive_hover_bg
        sect_fg = inactive_hover_fg
        end_fg = inactive_hover_bg
        end_bg = background
    else
        sect_bg = inactive_bg
        sect_fg = inactive_fg
        end_fg = inactive_bg
        end_bg = background
    end

    local index = string.format(" %s ", tab.tab_index + 1)
    local title = tab_title(tab)
    local zoomed = ""
    if tab.active_pane.is_zoomed then
        zoomed = wezterm.nerdfonts.md_alpha_z_box
    end

    return wezterm.format({
        { Background = { Color = end_bg } },
        { Foreground = { Color = end_fg } },
        { Text = " " .. wezterm.nerdfonts.ple_left_half_circle_thick },
        { Background = { Color = sect_bg } },
        { Foreground = { Color = sect_fg } },
        { Text = zoomed },
        { Background = { Color = sect_bg } },
        { Foreground = { Color = sect_fg } },
        { Attribute = { Intensity = "Half" } },
        { Text = index },
        "ResetAttributes",
        { Background = { Color = sect_bg } },
        { Foreground = { Color = sect_fg } },
        { Text = title },
        { Background = { Color = end_bg } },
        { Foreground = { Color = end_fg } },
        { Text = wezterm.nerdfonts.ple_right_half_circle_thick .. " " },
    })
end)

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
        { Text = "  " },
        { Text = wezterm.nerdfonts.ple_upper_right_triangle },
        { Background = { Color = background } },
        { Foreground = { Color = colors.text } },
        { Text = " " .. window:active_workspace() .. " " },
        { Background = { Color = background } },
        { Foreground = { Color = colors.blue } },
        { Text = wezterm.nerdfonts.ple_upper_right_triangle },
        -- { Text = wezterm.nerdfonts.ple_left_half_circle_thick },
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

local config = {}
if wezterm.config_builder then config = wezterm.config_builder {} end

config = {
    term                                       = "wezterm",
    -- Font config
    font                                       = font_with_fallback(maple_font),
    warn_about_missing_glyphs                  = false,
    font_size                                  = 16,
    line_height                                = 1.0,
    underline_thickness                        = "300%",
    adjust_window_size_when_changing_font_size = false,
    -- Cursor style
    default_cursor_style                       = "BlinkingBar",
    -- X11
    enable_wayland                             = enable_wayland(),
    -- Colorscheme
    colors                                     = {
        split = colors.surface0,
        foreground = colors.text,
        background = colors.crust,
        cursor_bg = colors.rosewater,
        cursor_border = colors.rosewater,
        cursor_fg = colors.crust,
        selection_bg = colors.surface2,
        selection_fg = colors.text,
        visual_bell = colors.surface0,
        indexed = {
            [16] = colors.peach,
            [17] = colors.rosewater,
        },
        scrollbar_thumb = colors.surface2,
        compose_cursor = colors.flamingo,
        ansi = {
            colors.surface1,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.pink,
            colors.teal,
            colors.subtext0,
        },
        brights = {
            colors.subtext0,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.pink,
            colors.teal,
            colors.surface1,
        },
        tab_bar = {
            background = colors.crust,
            active_tab = {
                bg_color = colors.lavender,
                fg_color = colors.crust,
                intensity = "Bold",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = colors.crust,
                fg_color = colors.surface2,
                italic = true,
            },
            inactive_tab_hover = {
                bg_color = colors.mantle,
                fg_color = colors.subtext0,
            },
            new_tab = {
                bg_color = colors.crust,
                fg_color = colors.subtext0,
            },
            new_tab_hover = {
                bg_color = colors.crust,
                fg_color = colors.subtext0,
            },
        },
    },
    command_palette_fg_color                   = colors.text,
    command_palette_bg_color                   = colors.surface0,
    -- Window
    window_padding                             = {
        left   = 8,
        right  = 8,
        top    = 8,
        bottom = 8,
    },
    initial_cols                               = 110,
    initial_rows                               = 25,
    inactive_pane_hsb                          = {
        saturation = 0.9,
        brightness = 0.50
    },
    window_background_opacity                  = get_opacity(get_os[wezterm.target_triple]),
    text_background_opacity                    = get_opacity(get_os[wezterm.target_triple]),
    window_frame                               = {
        font = font_with_fallback(maple_font, { bold = true })
    },
    window_decorations                         = "RESIZE",
    window_close_confirmation                  = "NeverPrompt",
    -- General
    automatically_reload_config                = true,
    audible_bell                               = "Disabled",
    enable_scroll_bar                          = false,
    -- Tab Bar
    enable_tab_bar                             = true,
    use_fancy_tab_bar                          = false,
    hide_tab_bar_if_only_one_tab               = false,
    show_tab_index_in_tab_bar                  = false,
    tab_bar_at_bottom                          = false,
    show_new_tab_button_in_tab_bar             = false,
    tab_max_width                              = 150,
    -- Keybinds
    disable_default_key_bindings               = false,
    keys                                       = {
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
        -- Prompt for a name to use for a new workspace and switch to it.
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
                    -- line will be `nil` if they hit escape without entering anything
                    -- An empty string if they just hit enter
                    -- Or the actual line of text they wrote
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
        -- Show the launcher in fuzzy selection mode and have it list all workspaces
        -- and allow activating one.
        {
            key = "w",
            mods = "ALT|SHIFT",
            action = wezterm.action.ShowLauncherArgs({
                flags = "FUZZY|WORKSPACES",
            }),
        },
        { key = "n", mods = "CTRL", action = wezterm.action.SwitchWorkspaceRelative(1) },
        { key = "p", mods = "CTRL", action = wezterm.action.SwitchWorkspaceRelative(-1) },
    },
    hyperlink_rules                            = {
        {
            regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
            format = "$0",
        },
        {
            regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
            format = "$0",
        },
        {
            regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
            format = "mailto:$0",
        },
        {
            regex = [[\bfile://\S*\b]],
            format = "$0",
        },
        {
            regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
            format = "$0",
        },
        {
            regex = [[\b[tT](\d+)\b]],
            format = "https://example.com/tasks/?t=$1",
        },
    },
}

-- Windows specific config
if get_os[wezterm.target_triple] == "Windows" then
    config.default_prog = { "pwsh.exe -nologo" }
    table.insert(config.launch_menu, { label = "pwsh", args = { "pwsh.exe", "-nologo" } })
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
end

return config
