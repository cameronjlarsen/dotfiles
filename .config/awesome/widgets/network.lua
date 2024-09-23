local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local icon_dir  = require("gears").filesystem.get_configuration_dir() .. "icons/network/"

local widget = wibox.widget {
    image         = icon_dir .. "wifi-strength-off.svg",
    auto_dpi      = true,
    widget        = wibox.widget.imagebox,
    forced_height = dpi(18),
    forced_width  = dpi(18),
    valign        = "center",
    halign        = "center",
    resize        = true
}

local tooltip = awful.tooltip {
    markup              = "Loading...",
    objects             = { widget },
    mode                = "mouse",
    align               = "right",
    preferred_positions = { "left", "right", "top", "bottom" },
    margin_leftright    = dpi(10),
    margin_topbottom    = dpi(10),
}

awesome.connect_signal("network::tooltip",
    function(message)
        tooltip.markup = message
    end
)

awesome.connect_signal("network::icon",
    function(icon)
        widget.image = gears.color.recolor_image(icon, beautiful.fg_normal)
    end
)

return widget
