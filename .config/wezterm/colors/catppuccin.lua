local wezterm = require("wezterm")

local M = {}

M.colors = {
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

local function apply(config)
    config.colors = {
        split = M.colors.surface0,
        foreground = M.colors.text,
        background = M.colors.crust,
        cursor_bg = M.colors.rosewater,
        cursor_border = M.colors.rosewater,
        cursor_fg = M.colors.crust,
        selection_bg = M.colors.surface2,
        selection_fg = M.colors.text,
        visual_bell = M.colors.surface0,
        indexed = {
            [16] = M.colors.peach,
            [17] = M.colors.rosewater,
        },
        scrollbar_thumb = M.colors.surface2,
        compose_cursor = M.colors.flamingo,
        ansi = {
            M.colors.surface1,
            M.colors.red,
            M.colors.green,
            M.colors.yellow,
            M.colors.blue,
            M.colors.pink,
            M.colors.teal,
            M.colors.subtext0,
        },
        brights = {
            M.colors.subtext0,
            M.colors.red,
            M.colors.green,
            M.colors.yellow,
            M.colors.blue,
            M.colors.pink,
            M.colors.teal,
            M.colors.surface1,
        },
        tab_bar = {
            background = M.colors.crust,
            active_tab = {
                bg_color = M.colors.lavender,
                fg_color = M.colors.crust,
                intensity = "Bold",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = M.colors.crust,
                fg_color = M.colors.surface2,
                italic = true,
            },
            inactive_tab_hover = {
                bg_color = M.colors.mantle,
                fg_color = M.colors.subtext0,
            },
            new_tab = {
                bg_color = M.colors.crust,
                fg_color = M.colors.subtext0,
            },
            new_tab_hover = {
                bg_color = M.colors.crust,
                fg_color = M.colors.subtext0,
            },
        },
    }
    config.command_palette_fg_color = M.colors.text
    config.command_palette_bg_color = M.colors.surface0

    return config
end

-- Make the module callable and export the colors
return setmetatable(M, {
    __call = function(_, config)
        return apply(config)
    end
})

