local awful = require("awful")
local mod   = require("config.bindings.mod")

local Alt   = mod.alt
local Super = mod.super
local Shift = mod.shift
local Ctrl  = mod.ctrl

client.connect_signal('request::default_mousebindings', function()
    awful.mouse.append_client_mousebindings {
        awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function(c) c:activate { context = 'mouse_click' } end
        },
        awful.button {
            modifiers = { Super },
            button    = 1,
            on_press  = function(c) c:activate { context = 'mouse_click', action = 'mouse_move' } end
        },
        awful.button {
            modifiers = { Super },
            button    = 3,
            on_press  = function(c) c:activate { context = 'mouse_click', action = 'mouse_resize' } end
        },
    }
end)
