local awful         = require("awful")
local apps          = require("config.apps")
local menu          = require("widgets.menu")
local mod           = require("config.bindings.mod")
local hotkeys_popup = require("awful.hotkeys_popup")
local bling         = require("modules.bling")
local naughty       = require("naughty")
require("awful.hotkeys_popup.keys.firefox")
require("awful.hotkeys_popup.keys.vim")

local Alt   = mod.alt
local Super = mod.super
local Shift = mod.shift
local Ctrl  = mod.ctrl

-- general awesome keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { Super, },
        key         = "/",
        description = "show help",
        group       = "awesome",
        on_press    = hotkeys_popup.show_help,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "w",
        description = "show main menu",
        group       = "awesome",
        on_press    = function() menu.rootmenu:show() end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "r",
        description = "reload awesome",
        group       = "awesome",
        on_press    = awesome.restart,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "q",
        description = "quit awesome",
        group       = "awesome",
        on_press    = awesome.quit,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Return",
        description = "open a terminal",
        group       = "launcher",
        on_press    = function() awful.spawn(apps.terminal) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Return",
        description = "open a Tdrop terminal",
        group       = "launcher",
        on_press    = function() awful.spawn(apps.tdrop) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "r",
        description = "run rofi",
        group       = "launcher",
        on_press    = function() awful.spawn(apps.launcher) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "w",
        description = "launch web browser",
        group       = "launcher",
        on_press    = function() awful.spawn(apps.web_browser) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "f",
        description = "launch file manager",
        group       = "launcher",
        on_press    = function() awful.spawn(apps.file_manager) end,
    },
})

-- hotkeys bindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = {},
        key         = "XF86AudioRaiseVolume",
        description = "increase volume",
        group       = "volume",
        on_press    = function()
            awful.spawn("pamixer -i 5")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86AudioLowerVolume",
        description = "decrease volume",
        group       = "volume",
        on_press    = function()
            awful.spawn("pamixer -d 5")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86AudioMute",
        description = "mute volume",
        group       = "volume",
        on_press    = function()
            awful.spawn("pamixer -t")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86MonBrightnessUp",
        description = "Increase monitor brightness",
        group       = "brightness",
        on_press    = function()
            awful.spawn("brightnessctl set 5%+ -q")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86MonBrightnessDown",
        description = "Decrease monitor brightness",
        group       = "brightness",
        on_press    = function()
            awful.spawn("brightnessctl set 5%- -q")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "Print",
        description = "manual capture",
        group       = "screenshot",
        on_press    = function()
            awful.spawn("flameshot gui")
        end,
    },
    awful.key {
        modifiers   = { Shift },
        key         = "Print",
        description = "single screen capture",
        group       = "screenshot",
        on_press    = function()
            awful.spawn("flameshot screen")
        end,
    },
    awful.key {
        modifiers   = { Ctrl },
        key         = "Print",
        description = "open capture launcher",
        group       = "screenshot",
        on_press    = function()
            awful.spawn("flameshot launcher")
        end,
    },
    awful.key {
        modifiers   = { Alt, Super },
        key         = "l",
        description = "lockscreen",
        group       = "screen",
        on_press    = function()
            awful.spawn.with_shell("betterlockscreen -l dim")
        end,
    },

}

-- tags related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super },
        key         = "Left",
        description = "view preivous",
        group       = "tag",
        on_press    = awful.tag.viewprev,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Right",
        description = "view next",
        group       = "tag",
        on_press    = awful.tag.viewnext,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Escape",
        description = "go back",
        group       = "tag",
        on_press    = awful.tag.history.restore,
    },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super },
        key         = "j",
        description = "focus next client below",
        group       = "client",
        on_press    = function()
            awful.client.focus.global_bydirection("down")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "k",
        description = "focus next client above",
        group       = "client",
        on_press    = function()
            awful.client.focus.global_bydirection("up")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "h",
        description = "focus next client left",
        group       = "client",
        on_press    = function()
            awful.client.focus.global_bydirection("left")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "l",
        description = "focus next client right",
        group       = "client",
        on_press    = function()
            awful.client.focus.global_bydirection("right")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Tab",
        description = "go back",
        group       = "client",
        on_press    = function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "j",
        description = "focus the next screen",
        group       = "screen",
        on_press    = function() awful.screen.focus_relative(1) end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "n",
        description = "restore minimized",
        group       = "client",
        on_press    = function()
            local c = awful.client.restore()
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
    },
}

-- layout related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super, Shift },
        key         = "j",
        description = "swap with next client below",
        group       = "client",
        on_press    = function() awful.client.swap.global_bydirection("down") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "k",
        description = "swap with next client above",
        group       = "client",
        on_press    = function() awful.client.swap.global_bydirection("up") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "h",
        description = "swap with next client left",
        group       = "client",
        on_press    = function() awful.client.swap.global_bydirection("left") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "l",
        description = "swap with next client right",
        group       = "client",
        on_press    = function() awful.client.swap.global_bydirection("right") end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "u",
        description = "jump to urgent client",
        group       = "client",
        on_press    = awful.client.urgent.jumpto,
    },
    awful.key {
        modifiers   = { Super, Alt },
        key         = "Left",
        description = "decrease master width factor",
        group       = "layout",
        on_press    = function() awful.tag.incmwfact(-0.05) end,
    },
    awful.key {
        modifiers   = { Super, Alt },
        key         = "Right",
        description = "increase master width factor",
        group       = "layout",
        on_press    = function() awful.tag.incmwfact(0.05) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Left",
        description = "decrease the number of master clients",
        group       = "layout",
        on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Right",
        description = "increase the number of master clients",
        group       = "layout",
        on_press    = function() awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "Left",
        description = "decrease the number of columns",
        group       = "layout",
        on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "Right",
        description = "increase the number of columns",
        group       = "layout",
        on_press    = function() awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "space",
        description = "select next",
        group       = "layout",
        on_press    = function() awful.layout.inc(1) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "space",
        description = "select previous",
        group       = "layout",
        on_press    = function() awful.layout.inc(-1) end,
    },
    awful.key {
        modifiers = { Alt },
        key = "a",
        description = "add client to tab group",
        group = "tabs",
        on_press = function()
            bling.module.tabbed.pick_with_dmenu()
        end,
    },
    awful.key {
        modifiers = { Alt },
        key = "d",
        description = "remove client from tab group",
        group = "tabs",
        on_press = function()
            bling.module.tabbed.pop()
        end,
    },
    awful.key {
        modifiers = { Alt },
        key = "s",
        description = "cycle through tab group",
        group = "tabs",
        on_press = function()
            bling.module.tabbed.iter()
        end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "o",
        description = "swap screens",
        group       = "client",
        on_press    = function()
            local focused_screen = awful.screen.focused()
            local s = focused_screen.get_next_in_direction(focused_screen, "right")

            -- FIXME: this only makes sense for two screens
            if not s then
                s = focused_screen.get_next_in_direction(focused_screen, "left")
            end

            if not s then
                naughty.notify { preset = naughty.config.presets.critical, title = "could not get other screen" }
                return
            end
            focused_screen:swap(s)

        end,
    },
}

-- Tag related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local s
            if screen.count() > 1 then
                if index > 0 and index < 6 then
                    s = screen[1]
                elseif index == 0 then
                    s = screen[2]
                    index = 5
                else
                    s = screen[2]
                    index = index - 5
                end
            else
                s = screen[1]
            end
            local tag = s.tags[index]
            if tag then
                tag:view_only()
            end
        end
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local s
            if screen.count() > 1 then
                if index > 0 and index < 6 then
                    s = screen[1]
                elseif index == 0 then
                    s = screen[2]
                    index = 5
                else
                    s = screen[2]
                    index = index - 5
                end
            else
                s = screen[1]
            end
            local tag = s.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end
    },
    awful.key {
        modifiers   = { Super, Shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local s
                if screen.count() > 1 then
                    if index > 0 and index < 6 then
                        s = screen[1]
                    elseif index == 0 then
                        s = screen[2]
                        index = 5
                    else
                        s = screen[2]
                        index = index - 5
                    end
                else
                    s = screen[1]
                end
                local tag = s.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end
    },
    awful.key {
        modifiers   = { Super, Ctrl, Shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local s
                if screen.count() > 1 then
                    if index > 0 and index < 6 then
                        s = screen[1]
                    elseif index == 0 then
                        s = screen[2]
                        index = 5
                    else
                        s = screen[2]
                        index = index - 5
                    end
                else
                    s = screen[1]
                end
                local tag = s.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { Super },
        keygroup    = "numpad",
        description = "select layout directrly",
        group       = "layout",
        on_press    = function(index)
            local tag = awful.screen.focused().selected_tag
            if tag then
                tag.layout = tag.layouts[index] or tag.layout
            end
        end
    },
}
