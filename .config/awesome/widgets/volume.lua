local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local widget = wibox.widget({
    font   = beautiful.font_icon .. 18,
    valign = "center",
    widget = wibox.widget.textbox,
})

local tooltip = awful.tooltip {
    markup              = "Loading...",
    objects             = { widget },
    mode                = "outside",
    align               = "right",
    preferred_positions = { "left", "right", "top", "bottom" },
    margin_leftright    = dpi(10),
    margin_topbottom    = dpi(10),
}

awesome.connect_signal("signal::volume", function(volume, mute)
    if mute then
        widget.text = ""
        tooltip.markup = "Muted"
    else
        tooltip.markup = volume .. "%"
        if volume > 100 then
            widget.text = ""
        elseif volume >= 50 then
            widget.text = ""
        elseif volume >= 25 then
            widget.text = ""
        elseif volume > 0 then
            widget.text = ""
        elseif volume == 0 then
            widget.text = ""
        end
    end
end)

return widget
