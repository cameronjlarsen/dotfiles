local bling = require("modules.bling")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

bling.widget.tag_preview.enable {
    show_client_content = true,
    x = 10, -- x-coord of the popup
    y = 10, -- y-coord of the popup
    scale = 0.25, -- The scaling factor of the previews compared to the screen.
    honor_padding = true, -- Honor screen padding
    honor_workarea = false, -- Honor screen workarea
    placement_fn = function(c)
        awful.placement.top_left(c, {
            margins = {
                top = dpi(70),
                left = dpi(30),
            },
            parent = awful.screen.focused(),
        })
    end,
    background_widget = wibox.widget {
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy = "fit",
        widget = wibox.widget.imagebox,
    }
}
