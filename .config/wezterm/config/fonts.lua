local wezterm = require("wezterm")

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

return function(config)
    config.font = font_with_fallback(maple_font)
    config.warn_about_missing_glyphs = false
    config.font_size = 16
    config.line_height = 1.0
    config.underline_thickness = "300%"
    config.adjust_window_size_when_changing_font_size = false

    config.window_frame = {
        font = font_with_fallback(maple_font, { bold = true })
    }

    return config
end

