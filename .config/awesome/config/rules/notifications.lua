local awful     = require("awful")
local naughty   = require("naughty")
local ruled     = require("ruled")
local beautiful = require("beautiful")

-- Notifications
ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen           = awful.screen.preferred,
            border_width     = beautiful.notification_border_width,
            margin           = beautiful.notification_margin,
            implicit_timeout = 5,
        },
    })
    -- Set different colors for urgent notifications.
    ruled.notification.append_rule({
        rule = {
            urgency = "critical",
        },
        properties = {
            font         = beautiful.font_italic,
            border_color = beautiful.border_color_urgent,
            margin       = beautiful.notification_margin,
            timeout      = 0,
        },
    })
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box({ notification = n })
end)
