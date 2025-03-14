local os_detection = require("utils.os_detection")

return function(config)
    -- Window appearance settings
    config.window_padding = {
        left   = 8,
        right  = 8,
        top    = 8,
        bottom = 8,
    }
    config.initial_cols = 110
    config.initial_rows = 25
    config.inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.50
    }
    config.window_background_opacity = 1
    config.text_background_opacity = 1
    config.window_decorations = "RESIZE"
    config.window_close_confirmation = "NeverPrompt"

    -- Cursor
    config.default_cursor_style = "BlinkingBar"

    -- Tab Bar appearance
    config.enable_tab_bar = true
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = false
    config.show_tab_index_in_tab_bar = false
    config.tab_bar_at_bottom = false
    config.show_new_tab_button_in_tab_bar = false
    config.tab_max_width = 150

    -- Other visual settings
    config.audible_bell = "Disabled"
    config.enable_scroll_bar = false

    -- Wayland specific
    config.enable_wayland = os_detection.enable_wayland()

    return config
end

