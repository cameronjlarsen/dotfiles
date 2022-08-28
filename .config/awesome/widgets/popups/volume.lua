local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local volumeDisplay = wibox({
    width = dpi(200),
    height = dpi(100),
    bg = beautiful.wibar_container_bg,
    ontop = true,
    visible = false,
    -- shape = function(cr, width, height, radius)
    --     gears.shape.rounded_rect(cr, width, height, radius)
    -- end,
    border_width = dpi(2),
    border_color = beautiful.border_color_active,
})

local header = wibox.widget({
    text = "Volume",
    valign = "center",
    widget = wibox.widget.textbox,
})

local percent = wibox.widget({
    widget = wibox.widget.textbox,
})

local icon = wibox.widget({
    font = beautiful.font_icon .. 20,
    valign = "center",
    widget = wibox.widget.textbox,
})

local slider = wibox.widget({
    bar_shape = gears.shape.rounded_rect,
    bar_height = dpi(5),
    bar_color = beautiful.bg_focus,
    bar_active_color = beautiful.fg_normal,
    handle_color = beautiful.fg_normal,
    handle_shape = gears.shape.circle,
    handle_width = dpi(10),
    handle_border_width = dpi(0),
    handle_border_color = beautiful.bg_normal,
    maximum = 100,
    widget = wibox.widget.slider,
})

local displayTimer = gears.timer({
    timeout = 2,
    single_shot = true,
    callback = function()
        volumeDisplay.visible = false
    end,
})

volumeDisplay:setup({
    {
        {
            {
                {
                    header,
                    nil,
                    percent,
                    layout = wibox.layout.align.horizontal,
                },
                left = dpi(15),
                right = dpi(15),
                top = dpi(10),
                bottom = dpi(10),
                widget = wibox.container.margin,
            },
            bg = beautiful.wibar_container_bg,
            widget = wibox.container.background,
        },
        {
            {
                {
                    icon,
                    right = dpi(15),
                    widget = wibox.container.margin,
                },
                nil,
                slider,
                layout = wibox.layout.align.horizontal,
            },
            left = dpi(15),
            right = dpi(15),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.vertical,
    },
    layout = wibox.container.place,
})

awesome.connect_signal("signal::volume", function(volume, mute)
    if mute then
        percent.text = "Muted"
        slider.value = 0
        icon.text = ""
    else
        percent.text = tostring(volume) .. "%"
        slider.value = volume
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

awesome.connect_signal("widget::volume", function()
    if volumeDisplay.visible then
        displayTimer:stop()
    end
    displayTimer:start()

    awful.placement.top_right(volumeDisplay, {
        margins = {
            top = dpi(70),
            right = dpi(30),
        },
        parent = awful.screen.focused(),
    })
    volumeDisplay.visible = true
end)

return icon
