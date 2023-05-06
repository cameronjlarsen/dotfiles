local gears     = require("gears")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local wibox     = require("wibox")
local dpi       = beautiful.xresources.apply_dpi

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message
    }
end)

naughty.connect_signal("destroyed", function(n, reason)
    if not n.clients then return end
    if reason == require(
            "naughty.constants"
        ).notification_closed_reason.dismissed_by_user then
        local jumped = false
        for _, c in ipairs(n.clients) do
            c.urgent = true
            if jumped then
                c:activate {
                    context = "client.jumpto"
                }
            else
                c:jump_to()
                jumped = true
            end
        end
    end
end)

-- display notification
naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification    = n,
        position        = "top_right",
        border_width    = beautiful.notification_border_width,
        border_color    = beautiful.fg_normal,
        bg              = beautiful.bg_normal,
        fg              = beautiful.fg_normal,
        shape           = beautiful.notification_shape,
        minimum_width   = dpi(240),
        widget_template = {
            {
                {
                    {
                        {
                            {
                                image = n.app_icon or n.icon or beautiful.fallback_notif_icon,
                                forced_height = 32,
                                forced_width = 32,
                                valign = "center",
                                align = "center",
                                clip_shape = gears.shape.circle,
                                widget = wibox.widget.imagebox,
                            },
                            {
                                markup = n.app_name == "" and "Cannot detect app" or
                                    n.app_name,
                                align = "left",
                                valign = "center",
                                widget = wibox.widget.textbox,
                            },
                            spacing = dpi(10),
                            layout = wibox.layout.fixed.horizontal,
                        },
                        margins = dpi(10),
                        widget = wibox.container.margin,
                    },
                    {
                        {
                            {
                                markup = "",
                                widget = wibox.widget.textbox,
                            },
                            top = 1,
                            widget = wibox.container.margin,
                        },
                        bg = beautiful.border_color_normal,
                        widget = wibox.container.background,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                {
                    {
                        n.title == "" and nil or {
                            markup = "<b>" .. n.title .. "</b>",
                            align = "center",
                            valign = "center",
                            widget = wibox.widget.textbox,
                        },
                        {
                            markup = n.title == "" and "<b>" .. n.message .. "</b>" or n.message,
                            align = "center",
                            valign = "center",
                            widget = wibox.widget.textbox,
                        },
                        spacing = dpi(5),
                        layout = wibox.layout.fixed.vertical,
                    },
                    top = dpi(25),
                    left = dpi(12),
                    right = dpi(12),
                    bottom = dpi(15),
                    widget = wibox.container.margin,
                },
                {
                    {
                        base_layout = wibox.widget {
                            spacing = dpi(12),
                            layout = wibox.layout.flex.horizontal,
                        },
                        widget_template = {
                            {
                                {
                                    {
                                        id = "text_role",
                                        widget = wibox.widget.textbox,
                                    },
                                    widget = wibox.container.place,
                                },
                                top = dpi(7),
                                bottom = dpi(7),
                                left = dpi(4),
                                right = dpi(4),
                                widget = wibox.container.margin,
                            },
                            shape = gears.shape.rounded_bar,
                            bg = beautiful.bg_normal,
                            widget = wibox.container.background,
                        },
                        widget = naughty.list.actions,
                    },
                    margins = dpi(12),
                    widget = wibox.container.margin,
                },
                spacing = dpi(7),
                layout = wibox.layout.align.vertical,
            },
            widget       = wibox.container.background,
            bg           = beautiful.bg_normal,
            shape        = gears.shape.rounded_rect,
            fg           = beautiful.fg_normal,
            border_width = beautiful.notification_border_width,
            border_color = beautiful.notification_border_color,
        }
    }
end)
