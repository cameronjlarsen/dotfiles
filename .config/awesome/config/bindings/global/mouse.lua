local awful = require("awful")
local menu = require("widgets.menu")

--  Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button {
        modifiers = {},
        button = 1,
        on_press = function() menu.rootmenu:hide() end,
    },
    awful.button {
        modifiers = {},
        button = 3,
        on_press = function() menu.rootmenu:toggle() end,
    }
})
