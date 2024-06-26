local awful        = require("awful")
local gears        = require("gears")
local wibox        = require("wibox")
local beautiful    = require("beautiful")

local dpi          = beautiful.xresources.apply_dpi

----- Titlebar
local get_titlebar = function(c)
    -- Button
    local buttons = gears.table.join({
        awful.button({}, 1, function()
            c:activate { context = "titlebar", action = "mouse_move" }
        end),
        awful.button({}, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize" }
        end)
    })

    -- Titlebar's decorations
    local left = wibox.widget {
        awful.titlebar.widget.closebutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.minimizebutton(c),
        spacing = dpi(6),
        layout = wibox.layout.fixed.horizontal,
    }

    local middle = wibox.widget {
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal,
    }

    local right = wibox.widget {
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal,
    }

    local container = wibox.widget {
        bg = beautiful.titlebar_bg_normal,
        shape = gears.shape.partially_rounded_rect,
        widget = wibox.container.background,
    }

    c:connect_signal("focus", function() container.bg = beautiful.titlebar_bg_normal end)
    c:connect_signal("unfocus", function() container.bg = beautiful.titlebar_bg_normal end)

    return wibox.widget {
        {
            {
                left,
                middle,
                right,
                layout = wibox.layout.align.horizontal,
            },
            margins = { top = dpi(8), bottom = dpi(8), left = dpi(12), right = dpi(10) },
            widget = wibox.container.margin,
        },
        widget = container,
    }
end

local function top(c)
    local titlebar = awful.titlebar(c, {
        position = 'top',
        size = dpi(30),
    })

    titlebar:setup {
        widget = get_titlebar(c)
    }
end

client.connect_signal("request::titlebars", function(c)
    top(c)
end)
