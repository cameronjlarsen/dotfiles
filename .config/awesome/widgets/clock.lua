local awful = require "awful"
local wibox = require("wibox")

local clock = wibox.widget {
    format = "%a  %b %d, %y  %l:%M %p ",
    widget = wibox.widget.textclock
}

clock:connect_signal("mouse::enter", function()
    awesome.emit_signal("calendar::visibility", true)
end)

clock:connect_signal("mouse::leave", function()
    awesome.emit_signal("calendar::visibility", false)
end)

clock:connect_signal("button::press", function()
    awful.spawn.raise_or_spawn("morgen", nil, function(c)
        if c.class == "morgen" then
            c:jump_to()
            awesome.emit_signal("calendar::visibility", false)
            return true
        else
            awesome.emit_signal("calendar::visibility", false)
            return false
        end
    end)
end)



return clock
