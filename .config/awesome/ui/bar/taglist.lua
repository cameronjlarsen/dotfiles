local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dpi   = require("beautiful").xresources.apply_dpi
local mod   = require("config.bindings.mod")

local Super = mod.super

local internal_spacing = dpi(7)
local box_height       = dpi(5)
local box_width        = dpi(10)

local taglist_buttons = {
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ Super }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ Super }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
    end),
}

local function box_margins(widget)
    return {
        { widget, widget = wibox.container.place },
        top    = box_height,
        bottom = box_height,
        left   = box_width,
        right  = box_width,
        widget = wibox.container.margin
    }
end

local module = {}

function module.new(cfg)
    cfg               = cfg or {}
    local taglist_cfg = cfg.taglist or {}

    local screen       = cfg.screen or awful.screen.focused()
    taglist_cfg.screen = screen

    local buttons       = cfg.buttons or taglist_buttons
    taglist_cfg.buttons = buttons

    local overrides = {
        filter          = awful.widget.taglist.filter.all,
        widget_template = {
            box_margins {
                -- tag
                {
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                    align  = "center",
                    valign = "center"
                },
                id      = "list_separator",
                spacing = internal_spacing,
                layout  = wibox.layout.fixed.horizontal
            },
            id     = "background_role",
            widget = wibox.container.background,
        }
    }
    return awful.widget.taglist(gears.table.join(taglist_cfg, overrides))
end

return module
