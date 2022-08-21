local wibox = require("wibox")
local dpi   = require("beautiful").xresources.apply_dpi

local tray = wibox.widget {
    {
        widget = wibox.widget.systray
    },
    margins = { top = dpi(5), bottom = dpi(5), left = dpi(5), right = dpi(5) },
    widget = wibox.container.margin
}

return tray
