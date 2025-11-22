return function(config)
    -- Default term type
    config.term = "wezterm"

    -- General settings
    config.automatically_reload_config = true
    config.audible_bell = "Disabled"
    config.enable_kitty_keyboard = true
    config.enable_kitty_graphics = true

    return config
end
