local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    -- awful.wallpaper {
    --     screen = s,
    --     widget = {
    --         image     = beautiful.wallpaper,
    --         upscale   = true,
    --         downscale = true,
    --         horizontal_fit_policy = "fit",
    --         vertical_fit_policy = "fit",
    --         widget    = wibox.widget.imagebox,
    --         -- halign = "center",
    --         -- valign = "center",
    --         -- tiled  = false,
    --         -- widget = wibox.container.tile,
    --     }
    -- }
    gears.wallpaper.maximized(beautiful.wallpaper, s, false)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- Layouts and tag table
screen.connect_signal("request::desktop_decoration", function(s)
    tag.connect_signal("request::default_layouts", function()
        awful.layout.append_default_layouts({
            awful.layout.suit.tile,
            awful.layout.suit.fair,
            awful.layout.suit.spiral.dwindle,
            awful.layout.suit.floating,
        })
    end)
    -- Each screen has its own tag table.
    -- If two screens then split tag table
    if screen.count() > 1 then
        if s.index == 1 then
            awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
        elseif s.index == 2 then
            awful.tag({ "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])
        end
        -- All tags on one screen
    else
        awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    end
end)


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

-- Run autostart script
awful.spawn.with_shell("~/.config/awesome/config/autorun.sh")
