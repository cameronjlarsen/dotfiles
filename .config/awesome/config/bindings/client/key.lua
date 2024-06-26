local awful     = require("awful")
local mod       = require("config.bindings.mod")
local beautiful = require("beautiful")

local Alt       = mod.alt
local Super     = mod.super
local Shift     = mod.shift
local Ctrl      = mod.ctrl

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key {
            modifiers   = { Super },
            key         = "f",
            description = "toggle fullscreen",
            group       = "Client",
            on_press    = function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "q",
            description = "close",
            group       = "Client",
            on_press    = function(c) c:kill() end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "t",
            description = "toggle floating",
            group       = "Client",
            on_press    = function(c)
                c.floating = not c.floating
                if c.floating then
                    awful.placement.centered(c, { honor_workarea = true })
                    c:raise()
                end
            end,
        },
        awful.key {
            modifiers   = { Super, Ctrl },
            key         = "Return",
            description = "move to master",
            group       = "Client",
            on_press    = function(c) c:swap(awful.client.getmaster()) end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "o",
            description = "move to next screen",
            group       = "Client",
            on_press    = function(c) c:move_to_screen() end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "n",
            description = "minimize",
            group       = "Client",
            on_press    = function(c) c.minimized = true end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "m",
            description = "(un)maximize",
            group       = "Client",
            on_press    = function(c)
                c.maximized = not c.maximized
                if c.maximized then
                    awful.placement.maximize(c,
                        { honor_workarea = true, honor_padding = true, margins = beautiful.useless_gap * 2 })
                end
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super, Ctrl },
            key         = "m",
            description = "(un)maximize vertically",
            group       = "Client",
            on_press    = function(c)
                c.maximized_vertical = not c.maximized_vertical
                if c.maximized_vertical then
                    awful.placement.maximize_vertically(c,
                        { honor_workarea = true, honor_padding = true, margins = beautiful.useless_gap * 2 })
                end
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super, Shift },
            key         = "m",
            description = "(un)maximize horizontally",
            group       = "Client",
            on_press    = function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                if c.maximized_horizontal then
                    awful.placement.maximize_horizontally(c,
                        { honor_workarea = true, honor_padding = true, margins = beautiful.useless_gap * 2 })
                end
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super, Shift },
            key         = "s",
            description = "(un)stick",
            group       = "Client",
            on_press    = function(c)
                c.sticky = not c.sticky
            end,
        },
    }
end)
