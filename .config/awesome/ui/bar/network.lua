local wibox = require("wibox")
local beautiful = require("beautiful")

local icon = wibox.widget({
    font = beautiful.font_icon .. 18,
    valign = "center",
    widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::network", function(status)
    if status:match("connected") then
        awesome.connect_signal("signal::conn_type", function(conn_type)
            if conn_type:match("Wired") then
                icon.text = ""
            else
                awesome.connect_signal("signal::wifi", function(strength)
                    if strength < 20 then
                        icon.text = "\u{ebe4}"
                    elseif strength < 40 then
                        icon.text = "\u{ebd6}"
                    elseif strength < 60 then
                        icon.text = "\u{ebe1}"
                    elseif strength < 80 then
                        icon.text = "\u{e1ba}"
                    else
                        icon.text = "\u{e1d8}"
                    end
                end)
            end
        end)
    else
        icon.text = "\u{e1da}"

    end
end)

return icon
