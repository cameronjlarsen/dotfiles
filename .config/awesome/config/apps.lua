local apps = {}
apps = {
    terminal     = "wezterm",
    tdrop        = "tdrop -am -w 60% -h 50% -y 25% -x 20% --name 'tdropdropdown' wezterm start --always-new-process",
    text_editor  = "wezterm start nvim",
    web_browser  = "firefox-developer-edition",
    file_manager = "thunar",
    launcher     = "rofi -show drun ",
}


return apps
