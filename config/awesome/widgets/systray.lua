local wibox = require("wibox")

return wibox.widget {
    {
        {
            widget = wibox.widget.systray,
            horizontal = false,
            screen = "primary",
            base_size = 16,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.place,
    valign = "center",
    halign = "center",
}
