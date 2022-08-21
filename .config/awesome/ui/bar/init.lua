local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dpi   = require("beautiful").xresources.apply_dpi

-- Get widgets
local volume  = require("ui.bar.volume")
local clock   = require("ui.bar.clock")
local network = require("ui.bar.network")
local tray    = require("ui.bar.tray")
local margins = { top = dpi(5), bottom = dpi(5), left = dpi(10), right = dpi(10) }


screen.connect_signal("request::desktop_decoration", function(s)
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = require("ui.bar.layoutbox")(s)

    -- Create a taglist widget
    s.taglist = require("ui.bar.taglist").new({
        screen = s,
    })

    -- Create the wibox
    s.bar = awful.wibar({
        position          = "top",
        screen            = s,
        height            = dpi(38),
        margins           = { top = dpi(10), bottom = dpi(0), left = dpi(10), right = dpi(10) },
        shape             = gears.shape.rounded_rect,
        restrict_workarea = true
    })

    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            {

                s.taglist,
                widget  = wibox.widget,
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(10),
            },
            margins = margins,
            widget  = wibox.container.margin

        },
        { -- Middle widget
            {
                clock,
                widget  = wibox.widget,
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(10),
            },
            margins = margins,
            widget  = wibox.container.margin
        },
        { -- Right widgets
            {
                tray,
                network,
                volume,
                s.layoutbox,
                widget  = wibox.widget,
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(5),
            },
            margins = margins,
            widget  = wibox.container.margin
        },
    }
end)
