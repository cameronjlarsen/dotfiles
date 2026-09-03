local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local gears     = require("gears")
local dpi       = beautiful.xresources.apply_dpi

-- listens for requests to open/hide the systray popup in the focused screen ofc.
local function get_tray()
    return awful.screen.focused().tray
end

awesome.connect_signal("tray::toggle", function()
    get_tray().toggle()
end)

awesome.connect_signal("tray::visibility", function(v)
    if v then
        get_tray().show()
    else
        get_tray().hide()
    end
end)

screen.connect_signal("request::desktop_decoration", function(s)
    s.tray = {}

    s.tray.widget = wibox.widget {
        {
            {
                {
                    widget = wibox.widget.systray,
                    horizontal = false,
                    screen = "primary",
                    base_size = 16,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            margins = dpi(12),
            widget = wibox.container.margin,
        },
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        visible = false,
        widget = wibox.container.background,
        shape = gears.shape.rounded_rect,
    }

    s.tray.popup = awful.popup {
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal,
        visible = false,
        ontop = true,
        maximum_width = dpi(200),
        maximum_height = dpi(150),
        placement = function(d)
            return awful.placement.top_right(d, {
                margins = {
                    top = beautiful.wibar_height + beautiful.wibar_margin + beautiful.useless_gap * 2,
                    bottom = beautiful.wibar_height + beautiful.wibar_margin + beautiful.useless_gap * 2,
                    right = beautiful.useless_gap * 20,
                    left = beautiful.useless_gap * 20,
                }
            })
        end,
        shape = gears.shape.rounded_rect,
        screen = s,
        widget = s.tray.widget,
    }

    local self = s.tray.popup

    function s.tray.show()
        self.visible = true
    end

    function s.tray.hide()
        self.visible = false
    end

    function s.tray.toggle()
        self.visible = not self.visible
    end
end)
