local wezterm = require("wezterm")
local hostname = wezterm.hostname()
local get_os = io.popen("uname -s", "r"):read("*l")

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

local function font_with_fallback(name, params)
    local names = { name, "Apple Color Emoji", "Noto Color Emoji", "Material Icons Rounded" }
    return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font"

local function is_vi_process(pane)
    return pane:get_foreground_process_name():find("n?vim") ~= nil
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
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
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
            { Text = wezterm.nerdfonts.mdi_hexagon },
        },
        ["zsh"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_terminal },
        },
        ["bash"] = {
            { Foreground = { Color = colors.subtext0 } },
            { Text = wezterm.nerdfonts.cod_terminal_bash },
        },
        ["htop"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
        },
        ["btop"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
        },
        ["cargo"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_rust },
        },
        ["go"] = {
            { Foreground = { Color = colors.sapphire } },
            { Text = wezterm.nerdfonts.mdi_language_go },
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
            { Text = wezterm.nerdfonts.mdi_arrow_down_box },
        },
        ["curl"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_flattr },
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
    }

    local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

    return wezterm.format(
        process_icons[process_name]
        or { { Foreground = { Color = colors.sky } }, { Text = string.format("[%s]", process_name) } }
    )
end

local function get_current_working_dir(tab)
    local current_dir = tab.active_pane.current_working_dir
    local ROOT_DIR = string.format("file://%s/", hostname:lower())
    local HOME_DIR = string.format("file://%s%s/", hostname:lower(), os.getenv("HOME"))

    local new_dir = string.format("%s", string.gsub(current_dir, "(.*[/\\])(.*[^/\\])[/\\]?$", "%2"))

    if current_dir == HOME_DIR then
        new_dir = "~"
    elseif current_dir == ROOT_DIR then
        new_dir = "/"
    end

    return new_dir
end

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return string.format("%s %s", get_process(tab_info), title)
    end

    return string.format("%s %s", get_process(tab_info), get_current_working_dir(tab_info))
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local active_tab_index = 0
    for _, t in ipairs(tabs) do
        if t.is_active then
            active_tab_index = t.tab_index
        end
    end

    local rainbow = {
        config.resolved_palette.ansi[2],
        config.resolved_palette.indexed[16],
        config.resolved_palette.ansi[4],
        config.resolved_palette.ansi[3],
        config.resolved_palette.ansi[5],
        config.resolved_palette.ansi[6],
    }

    local i = tab.tab_index % 6
    local background = config.colors.tab_bar.background
    -- local active_bg = rainbow[i + 1]
    local active_bg = config.colors.tab_bar.active_tab.bg_color
    local active_fg = config.colors.tab_bar.active_tab.fg_color
    local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
    local inactive_fg = config.colors.tab_bar.inactive_tab.fg_color
    local new_tab_bg = config.colors.tab_bar.new_tab.bg_color
    local inactive_hover_bg = config.colors.tab_bar.inactive_tab_hover.bg_color
    local inactive_hover_fg = config.colors.tab_bar.inactive_tab_hover.fg_color

    local s_bg, s_fg, e_bg, e_fg

    -- the last tab
    if tab.tab_index == #tabs - 1 then
        if tab.is_active then
            s_bg = active_bg
            s_fg = active_fg
            e_bg = new_tab_bg
            e_fg = active_bg
        elseif hover then
            s_bg = inactive_hover_bg
            s_fg = inactive_hover_fg
            e_bg = new_tab_bg
            e_fg = inactive_hover_bg
        else
            s_bg = inactive_bg
            s_fg = inactive_fg
            e_bg = new_tab_bg
            e_fg = inactive_bg
        end
    elseif tab.tab_index == active_tab_index - 1 then
        s_bg = inactive_bg
        s_fg = inactive_fg
        e_bg = active_bg
        -- e_bg = rainbow[(i + 1) % 6 + 1]
        e_fg = inactive_bg
    elseif tab.is_active then
        s_bg = active_bg
        s_fg = active_fg
        e_bg = inactive_bg
        e_fg = active_bg
    elseif hover then
        s_bg = inactive_hover_bg
        s_fg = inactive_hover_fg
        e_bg = new_tab_bg
        e_fg = inactive_hover_bg
    else
        s_bg = inactive_bg
        s_fg = inactive_fg
        e_bg = inactive_bg
        e_fg = inactive_bg
    end

    local index = string.format(" %s ", tab.tab_index + 1)
    local title = tab_title(tab)

    return wezterm.format({
        { Background = { Color = background } },
        { Foreground = { Color = s_bg } },
        { Text = " " },
        { Background = { Color = s_bg } },
        { Foreground = { Color = s_fg } },
        { Attribute = { Intensity = "Half" } },
        { Text = index },
        "ResetAttributes",
        { Background = { Color = s_bg } },
        { Foreground = { Color = s_fg } },
        { Text = title },
        { Background = { Color = background } },
        { Foreground = { Color = e_fg } },
        { Text = " " },
    })
end)

wezterm.on("update-right-status", function(window)
    local battery_info = {}
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(battery_info, string.format("%.0f%%", b.state_of_charge * 100))
    end

    window:set_right_status(wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Text = wezterm.strftime(" %A, %B %d %Y %I:%M %p ") },
        { Text = table.concat(battery_info, " ") },
    }))
end)


return {
    term                                       = "wezterm",
    -- OpenGL for GPU acceleration, Software for CPU
    front_end                                  = "OpenGL",
    -- Font config
    font                                       = font_with_fallback(font_name),
    warn_about_missing_glyphs                  = false,
    font_size                                  = 16,
    line_height                                = 1.0,
    underline_thickness                        = "300%",
    adjust_window_size_when_changing_font_size = false,
    show_update_window                         = false,
    -- Cursor style
    default_cursor_style                       = "BlinkingBar",
    -- X11
    enable_wayland                             = enable_wayland(),
    -- Colorscheme
    colors                                     = {
        split = colors.surface0,
        foreground = colors.text,
        background = colors.base,
        cursor_bg = colors.rosewater,
        cursor_border = colors.rosewater,
        cursor_fg = colors.base,
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
                bg_color = colors.surface0,
                fg_color = colors.subtext1,
                intensity = "Bold",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = colors.crust,
                fg_color = colors.surface2,
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
    window_background_opacity                  = get_opacity(get_os),
    window_frame                               = {
        font = font_with_fallback(font_name, { bold = true })
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
        { key = "t",     mods = "CTRL|SHIFT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }), },
        { key = "w",     mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }), },
        { key = "q",     mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
        { key = "z",     mods = "ALT",        action = wezterm.action.TogglePaneZoomState },
        { key = "F11",   mods = "",           action = wezterm.action.ToggleFullScreen },
        { key = "h",     mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
        { key = "j",     mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
        { key = "k",     mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
        { key = "l",     mods = "ALT|SHIFT",  action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
        { key = "h",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
        { key = "j",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
        { key = "k",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
        { key = "l",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
        { key = "[",     mods = "ALT",        action = wezterm.action({ ActivateTabRelative = -1 }) },
        { key = "]",     mods = "ALT",        action = wezterm.action({ ActivateTabRelative = 1 }) },
        { key = "{",     mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(-1) },
        { key = "}",     mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(1) },
        { key = "v",     mods = "ALT",        action = wezterm.action.ActivateCopyMode },
        { key = "c",     mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "v",     mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        { key = "=",     mods = "CTRL",       action = wezterm.action.IncreaseFontSize },
        { key = "-",     mods = "CTRL",       action = wezterm.action.DecreaseFontSize },
        { key = "1",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 1 }) },
        { key = "2",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 2 }) },
        { key = "3",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 3 }) },
        { key = "4",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 4 }) },
        { key = "5",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 5 }) },
        { key = "6",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 6 }) },
        { key = "7",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 7 }) },
        { key = "8",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 8 }) },
        { key = "9",     mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTab = 9 }) },
        { key = "Enter", mods = "ALT",        action = wezterm.action.DisableDefaultAssignment },
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
