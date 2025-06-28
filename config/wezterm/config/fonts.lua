local wezterm = require("wezterm")

local maple_font = {
    family = "Maple Mono NF",
    harfbuzz_features = {
        "cv01", "cv03", "cv04", "ss01", "ss02", "ss03", "ss04"
    },
}

local function font_with_fallback(font_config)
    -- If a string is passed, convert it to a table with family
    if type(font_config) == "string" then
        font_config = { family = font_config }
    end

    local fallback_chain = {
        font_config,
        { family = "JetBrainsMono Nerd Font" },
        { family = "Apple Color Emoji" },
        { family = "Noto Color Emoji" },
        { family = "Material Icons Rounded" },
        { family = "Symbols Nerd Font" }
    }
    return wezterm.font_with_fallback(fallback_chain)
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

