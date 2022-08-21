local wibox = require("wibox")
local beautiful = require("beautiful")

local icon = wibox.widget({
    font = beautiful.font_icon .. 18,
    valign = "center",
    widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::volume", function(volume, mute)
    if mute then
        icon.text = ""
    else
        if volume > 100 then
            icon.text = ""
        elseif volume >= 50 then
            icon.text = ""
        elseif volume >= 25 then
            icon.text = ""
        elseif volume > 0 then
            icon.text = ""
        elseif volume == 0 then
            icon.text = ""
        end
    end
end)

return icon
