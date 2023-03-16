local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")
require("awful.autofocus")

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
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
            awful.layout.suit.spiral.dwindle,
            awful.layout.suit.tile,
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

    s:connect_signal("swapped", function(self, other, is_source)
        if not is_source then return end

        local selected_tag = self.selected_tag
        local selected_clients = selected_tag:clients() -- NOTE: this is only here for convinience
        local other_tag = other.selected_tag
        local other_clients = other_tag:clients()       -- but this HAS to be saved in a variable because we modify the client list in the process of swapping

        for _, c in ipairs(selected_clients) do
            c:move_to_tag(other_tag)
        end

        for _, c in ipairs(other_clients) do
            c:move_to_tag(selected_tag)
        end
    end)
end)

-- This fixes fullscreen applications like games starting offset on screen
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

-- Set new clients as slave
client.connect_signal("request::manage", function(c)
    if not awesome.startup then awful.client.setslave(c) end
end)

-- Jump to urgent clients automatically
client.connect_signal("property::urgent", function(c)
    c:jump_to()
end)

client.connect_signal("property::maximized", function(c)
    awful.placement.maximize(c,
        { honor_workarea = true, honor_padding = true, margins = beautiful.useless_gap * 2 })
end)

-- Run autostart script
awful.spawn.with_shell("~/.config/awesome/config/autorun.sh")
