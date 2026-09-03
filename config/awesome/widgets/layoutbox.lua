local awful   = require("awful")
local wibox   = require("wibox")
local dpi     = require("beautiful").xresources.apply_dpi

local buttons = {
    awful.button({}, 1, function()
        awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
        awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
        awful.layout.inc(-1)
    end),
    awful.button({}, 5, function()
        awful.layout.inc(1)
    end),
}

return function(s)
    return wibox.widget {
        {
            widget = awful.widget.layoutbox {
                screen = s,
                buttons = buttons
            },
        },
        margins = dpi(0),
        widget = wibox.container.margin,
    }
end
