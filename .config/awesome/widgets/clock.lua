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



return clock
