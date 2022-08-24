local apps = {}
apps = {
    terminal     = "wezterm",
    tdrop        = "tdrop -am -w 60% -y 30% -x 20% kitty",
    text_editor  = "wezterm start nvim",
    web_browser  = "firefox",
    file_manager = "thunar",
    launcher     = "rofi -show drun ",
}


return apps
