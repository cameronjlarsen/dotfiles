local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local gears     = require("gears")
local dpi       = beautiful.xresources.apply_dpi

-- listen for requests to change the visibility of the calendar in the focused screen ofc.
local function get_calendar()
    return awful.screen.focused().calendar
end

awesome.connect_signal("calendar::toggle", function()
    get_calendar().toggle()
end)

awesome.connect_signal("calendar::visibility", function(v)
    if v then
        get_calendar().show()
    else
        get_calendar().hide()
    end
end)

screen.connect_signal("request::desktop_decoration", function(s)
    s.calendar = {}

    s.calendar.calendar = wibox.widget {
        date = os.date("*t"),
        start_sunday = true,
        font = beautiful.font_family .. " 10",
        spacing = dpi(2),
        widget = wibox.widget.calendar.month,
        fn_embed = function(widget, flag, date)
            local focus_widget = wibox.widget {
                text = date.day,
                align = "center",
                widget = wibox.widget.textbox,
            }

            local torender = flag == "focus" and focus_widget or widget

            local colors = {
                header = beautiful.colors.lavender,
                focus = beautiful.colors.blue,
                weekday = beautiful.colors.green
            }

            local color = colors[flag] or beautiful.fg_normal

            return wibox.widget {
                {
                    torender,
                    margins = dpi(7),
                    widget = wibox.container.margin,
                },
                bg = flag == "focus" and beautiful.colors.base or beautiful.bg_normal,
                fg = color,
                widget = wibox.container.background,
                shape = flag == "focus" and gears.shape.circle or nil,
            }
        end
    }

    s.calendar.popup = awful.popup {
        bg        = "#00000000",
        fg        = beautiful.fg_normal,
        visible   = false,
        ontop     = true,
        placement = function(d)
            return awful.placement.top(d, {
                margins = {
                    top = beautiful.wibar_height + beautiful.wibar_margin + beautiful.useless_gap * 2,
                    bottom = beautiful.wibar_height + beautiful.wibar_margin + beautiful.useless_gap * 2,
                    right = beautiful.useless_gap * 2,
                    left = beautiful.useless_gap * 2,
                },
            })
        end,
        shape     = gears.shape.rounded_rect,
        screen    = s,
        widget    = s.calendar.calendar,
    }

    local self = s.calendar.popup

    function s.calendar.show()
        self.visible = true
    end

    function s.calendar.hide()
        self.visible = false
    end

    function s.calendar.toggle()
        self.visible = not self.visible
    end
end)
