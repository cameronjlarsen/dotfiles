local wibox = require("wibox")

local clock = wibox.widget {
    format = "%a  %b %d, %y  %l:%M %p ",
    widget = wibox.widget.textclock
}

return clock
