local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local dpi       = require("beautiful").xresources.apply_dpi
local beautiful = require("beautiful")

-- Get widgets
local volume    = require("widgets.volume")
local clock     = require("widgets.clock")
local network   = require("widgets.network")
local margins   = { top = dpi(6), bottom = dpi(6), left = dpi(10), right = dpi(10) }

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = require("widgets.layoutbox")(s)

    -- Create a taglist widget
    s.taglist   = require("widgets.taglist").new({
        screen = s,
    })

    s.tray      = wibox.widget {
        font   = beautiful.font_icon .. 12,
        text   = " ",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox
    }

    s.tray:add_button(awful.button({}, 1, function()
        s.tray.text = s.tray.text == " " and "" or " "
        s.tray.widget.visible = not s.tray.widget.visible
    end))

    s.tray.widget = wibox.widget {
        {
            {
                widget = wibox.widget.systray,
                horizontal = false,
                screen = "primary",
                base_size = 16,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.place,
        valign = "center",
        halign = "center",
    }

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
                        s.taglist,
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
            widget  = wibox.container.margin
        },
        {
            -- Middle widget
            {
                {
                    {
                        clock,
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
                        s.tray.widget,
                        network,
                        volume,
                        s.layoutbox,
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
