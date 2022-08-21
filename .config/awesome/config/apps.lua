local apps = {}
apps = {
    terminal     = "kitty",
    web_browser  = "firefox",
    file_manager = "thunar",
    launcher     = "rofi -show drun ",
}

apps.tdrop  = "tdrop -am -w 60% -y 30% -x 20% " .. apps.terminal
apps.text_editor = apps.terminal.. " nvim"

return apps
