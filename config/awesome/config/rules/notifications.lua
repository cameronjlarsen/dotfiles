local awful     = require("awful")
local ruled     = require("ruled")
local beautiful = require("beautiful")

-- Notifications
ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen           = awful.screen.preferred,
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
            timeout      = 0,
        },
    })
end)
