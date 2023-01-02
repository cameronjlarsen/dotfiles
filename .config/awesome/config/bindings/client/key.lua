local awful     = require("awful")
local mod       = require("config.bindings.mod")
local beautiful = require("beautiful")

local Alt   = mod.alt
local Super = mod.super
local Shift = mod.shift
local Ctrl  = mod.ctrl

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key {
            modifiers   = { Super },
            key         = "f",
            description = "toggle fullscreen",
            group       = "client",
            on_press    = function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "q",
            description = "close",
            group       = "client",
            on_press    = function(c) c:kill() end,
        },
        awful.key {
            modifiers   = { Super, Ctrl },
            key         = "space",
            description = "toggle floating",
            group       = "client",
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
            group       = "client",
            on_press    = function(c) c:swap(awful.client.getmaster()) end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "o",
            description = "move to screen",
            group       = "client",
            on_press    = function(c) c:move_to_screen() end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "t",
            description = "toggle keep on top",
            group       = "client",
            on_press    = function(c) c.ontop = not c.ontop end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "n",
            description = "minimize",
            group       = "client",
            on_press    = function(c) c.minimized = true end,
        },
        awful.key {
            modifiers   = { Super },
            key         = "m",
            description = "(un)maximize",
            group       = "client",
            on_press    = function(c)
                local s = awful.screen.focused()
                if c.maximized then
                    s.padding = 0
                else
                    s.padding = beautiful.useless_gap * 2
                end
                c.maximized = not c.maximized
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super, Ctrl },
            key         = "m",
            description = "(un)maximize vertically",
            group       = "client",
            on_press    = function(c)
                local s = awful.screen.focused()
                if c.maximized_vertical then
                    s.padding = 0
                else
                    s.padding = beautiful.useless_gap
                end
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
        },
        awful.key {
            modifiers   = { Super, Shift },
            key         = "m",
            description = "(un)maximize horizontally",
            group       = "client",
            on_press    = function(c)
                local s = awful.screen.focused()
                if c.maximized_horizontal then
                    s.padding = 0
                else
                    s.padding = beautiful.useless_gap * 2
                end
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
        },
    }
end)
