local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local dpi       = require("beautiful").xresources.apply_dpi
local beautiful = require("beautiful")

-- Get widgets
local widgets   = {
    volume    = require("widgets.volume"),
    clock     = require("widgets.clock"),
    network   = require("widgets.network"),
    layoutbox = require("widgets.layoutbox"),
    taglist   = require("widgets.taglist"),
    systray   = require("widgets.systray")
}
local margins   = { top = dpi(6), bottom = dpi(6), left = dpi(10), right = dpi(10) }

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create the wibox
    s.bar = awful.wibar({
        position          = "top",
        screen            = s,
        height            = beautiful.wibar_height,
        margins           = beautiful.wibar_margin,
        shape             = gears.shape.rounded_rect,
        restrict_workarea = true
    })

    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            -- Left widgets
            {
                {
                    {
                        widgets.taglist.new({ screen = s }),
                        widget = wibox.widget,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    margins = { top = dpi(2), bottom = dpi(2), left = dpi(10), right = dpi(10) },
                    widget = wibox.container.margin,
                },
                widget = wibox.container.background,
                shape = gears.shape.rounded_rect,
                bg = beautiful.wibar_container_bg,
            },
            margins = margins,
            widget  = wibox.container.margin,
        },
        {
            -- Middle widget
            {
                {
                    {
                        widgets.clock,
                        widget  = wibox.widget,
                        layout  = wibox.layout.fixed.horizontal,
                        spacing = dpi(10),
                    },
                    margins = margins,
                    widget = wibox.container.margin,
                },
                widget = wibox.container.background,
                shape = gears.shape.rounded_rect,
                bg = beautiful.wibar_container_bg,
            },
            margins = margins,
            widget  = wibox.container.margin
        },
        {
            -- Right widgets
            {
                {
                    {
                        -- s.tray,
                        -- widgets.systray,
                        widgets.network,
                        widgets.volume,
                        widgets.layoutbox(s),
                        widget  = wibox.widget,
                        layout  = wibox.layout.fixed.horizontal,
                        spacing = dpi(5),
                    },
                    margins = margins,
                    widget  = wibox.container.margin,
                },
                widget = wibox.container.background,
                shape = gears.shape.rounded_rect,
                bg = beautiful.wibar_container_bg,
            },
            margins = margins,
            widget  = wibox.container.margin
        },
    }
end)
