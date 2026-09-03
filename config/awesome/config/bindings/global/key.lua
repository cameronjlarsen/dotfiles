local awful         = require("awful")
local apps          = require("config.apps")
local menu          = require("widgets.menu")
local mod           = require("config.bindings.mod")
local hotkeys_popup = require("awful.hotkeys_popup")
local bling         = require("modules.bling")
local naughty       = require("naughty")
require("awful.hotkeys_popup.keys.firefox")
require("awful.hotkeys_popup.keys.vim")

local Alt               = mod.alt
local Super             = mod.super
local Shift             = mod.shift
local Ctrl              = mod.ctrl

local focus_bydirection = function(direction)
    awful.client.focus.global_bydirection(direction)
    if client.focus then
        -- focus on the client
        client.focus:raise()
    end

    -- BUG: focus across screens is wonky when there are no clients on the destination screen
    -- https://github.com/awesomeWM/awesome/issues/3638
    -- Workaround: manually unfocus client after moving focus to an empty screen
    local is_empty_destination = #awful.screen.focused().clients < 1

    if is_empty_destination then
        -- manually unfocus the current focused client
        client.focus = nil
    end
end

-- general awesome keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { Super, },
        key         = "/",
        description = "show help",
        group       = "Awesome",
        on_press    = hotkeys_popup.show_help,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "w",
        description = "show main menu",
        group       = "Awesome",
        on_press    = function() menu.rootmenu:show() end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "r",
        description = "reload awesome",
        group       = "Awesome",
        on_press    = awesome.restart,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "q",
        description = "quit awesome",
        group       = "Awesome",
        on_press    = awesome.quit,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Return",
        description = "open a terminal",
        group       = "Launcher",
        on_press    = function() awful.spawn(apps.terminal) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Return",
        description = "open a Tdrop terminal",
        group       = "Launcher",
        on_press    = function() awful.spawn(apps.tdrop) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "r",
        description = "run rofi",
        group       = "Launcher",
        on_press    = function() awful.spawn(apps.launcher) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "w",
        description = "launch web browser",
        group       = "Launcher",
        on_press    = function() awful.spawn(apps.web_browser) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "f",
        description = "launch file manager",
        group       = "Launcher",
        on_press    = function() awful.spawn(apps.file_manager) end,
    },
})

-- hotkeys bindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = {},
        key         = "XF86AudioRaiseVolume",
        description = "increase volume",
        group       = "Volume",
        on_press    = function()
            awful.spawn("pamixer -i 5")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86AudioLowerVolume",
        description = "decrease volume",
        group       = "Volume",
        on_press    = function()
            awful.spawn("pamixer -d 5")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86AudioMute",
        description = "mute volume",
        group       = "Volume",
        on_press    = function()
            awful.spawn("pamixer -t")
            awesome.emit_signal("widget::volume")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86MonBrightnessUp",
        description = "Increase monitor brightness",
        group       = "Brightness",
        on_press    = function()
            awful.spawn("brightnessctl set 5%+ -q")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86MonBrightnessDown",
        description = "Decrease monitor brightness",
        group       = "Brightness",
        on_press    = function()
            awful.spawn("brightnessctl set 5%- -q")
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "Print",
        description = "manual capture",
        group       = "Screenshot",
        on_press    = function()
            awful.spawn("flameshot gui")
        end,
    },
    awful.key {
        modifiers   = { Shift },
        key         = "Print",
        description = "single screen capture",
        group       = "Screenshot",
        on_press    = function()
            awful.spawn("flameshot screen")
        end,
    },
    awful.key {
        modifiers   = { Ctrl },
        key         = "Print",
        description = "open capture launcher",
        group       = "Screenshot",
        on_press    = function()
            awful.spawn("flameshot launcher")
        end,
    },
    awful.key {
        modifiers   = { Alt, Super },
        key         = "l",
        description = "lockscreen",
        group       = "Screen",
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
        group       = "Tags",
        on_press    = awful.tag.viewprev,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Right",
        description = "view next",
        group       = "Tags",
        on_press    = awful.tag.viewnext,
    },
    awful.key {
        modifiers   = { Super },
        key         = "Escape",
        description = "go back",
        group       = "Tags",
        on_press    = awful.tag.history.restore,
    },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super },
        key         = "j",
        description = "focus next client below",
        group       = "Client",
        on_press    = function()
            focus_bydirection("down")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "k",
        description = "focus next client above",
        group       = "Client",
        on_press    = function()
            focus_bydirection("up")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "h",
        description = "focus next client left",
        group       = "Client",
        on_press    = function()
            focus_bydirection("left")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "l",
        description = "focus next client right",
        group       = "Client",
        on_press    = function()
            focus_bydirection("right")
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "j",
        description = "focus the next screen",
        group       = "Screen",
        on_press    = function()
            awful.screen.focus_relative(1)
            bling.module.flash_focus.flashfocus(client.focus)
        end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "n",
        description = "restore minimized",
        group       = "Client",
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
        group       = "Client",
        on_press    = function() awful.client.swap.global_bydirection("down") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "k",
        description = "swap with next client above",
        group       = "Client",
        on_press    = function() awful.client.swap.global_bydirection("up") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "h",
        description = "swap with next client left",
        group       = "Client",
        on_press    = function() awful.client.swap.global_bydirection("left") end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "l",
        description = "swap with next client right",
        group       = "Client",
        on_press    = function() awful.client.swap.global_bydirection("right") end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "u",
        description = "jump to urgent client",
        group       = "Client",
        on_press    = awful.client.urgent.jumpto,
    },
    awful.key {
        modifiers   = { Super, Alt },
        key         = "Left",
        description = "decrease master width factor",
        group       = "Layout",
        on_press    = function() awful.tag.incmwfact(-0.05) end,
    },
    awful.key {
        modifiers   = { Super, Alt },
        key         = "Right",
        description = "increase master width factor",
        group       = "Layout",
        on_press    = function() awful.tag.incmwfact(0.05) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Left",
        description = "decrease the number of master clients",
        group       = "Layout",
        on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "Right",
        description = "increase the number of master clients",
        group       = "Layout",
        on_press    = function() awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "Left",
        description = "decrease the number of columns",
        group       = "Layout",
        on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "Right",
        description = "increase the number of columns",
        group       = "Layout",
        on_press    = function() awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { Super },
        key         = "space",
        description = "select next",
        group       = "Layout",
        on_press    = function() awful.layout.inc(1) end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "space",
        description = "select previous",
        group       = "Layout",
        on_press    = function() awful.layout.inc(-1) end,
    },
    awful.key {
        modifiers = { Super },
        key = "g",
        description = "add client to tab group",
        group = "Tabs",
        on_press = function()
            bling.module.tabbed.pick_with_dmenu()
        end,
    },
    awful.key {
        modifiers = { Super, Shift },
        key = "g",
        description = "remove client from tab group",
        group = "Tabs",
        on_press = function()
            bling.module.tabbed.pop()
        end,
    },
    awful.key {
        modifiers = { Super },
        key = "Tab",
        description = "cycle through tab group",
        group = "Tabs",
        on_press = function()
            bling.module.tabbed.iter()
        end,
    },
    awful.key {
        modifiers   = { Super, Ctrl },
        key         = "o",
        description = "swap selected tags",
        group       = "Screen",
        on_press    = function()
            local self = awful.screen.focused()
            local other = self.get_next_in_direction(self, "right")

            -- FIXME: this only makes sense for two screens
            if not other then
                other = self.get_next_in_direction(self, "left")
            end

            if not other then
                naughty.notify { preset = naughty.config.presets.critical, title = "could not get other screen" }
                return
            end
            local selected_tag = self.selected_tag
            local selected_clients = selected_tag:clients() -- NOTE: this is only here for convinience
            local other_tag = other.selected_tag
            local other_clients = other_tag:clients()       -- but this HAS to be saved in a variable because we modify the client list in the process of swapping

            for _, c in ipairs(selected_clients) do
                c:move_to_tag(other_tag)
            end

            for _, c in ipairs(other_clients) do
                c:move_to_tag(selected_tag)
            end
        end,
    },
    awful.key {
        modifiers   = { Super, Shift },
        key         = "o",
        description = "swap all tags",
        group       = "Screen",
        on_press    = function()
            local self = awful.screen.focused()
            local other = self.get_next_in_direction(self, "right")

            -- FIXME: this only makes sense for two screens
            if not other then
                other = self.get_next_in_direction(self, "left")
            end

            if not other then
                naughty.notify { preset = naughty.config.presets.critical, title = "could not get other screen" }
                return
            end

            for _, t in ipairs(self.tags) do
                local fallback_tag = awful.tag.find_by_name(other, tostring(t.name + 5)) or
                    awful.tag.find_by_name(other, tostring(t.name - 5))
                local self_clients = t:clients()
                local other_clients

                -- If we don't have a tag by the same name, we'll just "throw" the
                -- client to the first tag on the other screen
                if not fallback_tag then
                    fallback_tag = other.tags[1]
                    other_clients = {}
                else
                    other_clients = fallback_tag:clients()
                end


                for _, c in ipairs(self_clients) do
                    c:move_to_tag(fallback_tag)
                end

                for _, c in ipairs(other_clients) do
                    c:move_to_tag(t)
                end
            end
        end,
    },
    awful.key {
        modifiers = { Super },
        key = "s",
        description = "toggle window swallowing",
        group = "Layout",
        on_press = function()
            bling.module.window_swallowing.toggle()
        end,
    },
}

-- Tag related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Super },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "Tags",
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
        group       = "Tags",
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
        group       = "Tags",
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
        group       = "Tags",
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
        group       = "Layout",
        on_press    = function(index)
            local tag = awful.screen.focused().selected_tag
            if tag then
                tag.layout = tag.layouts[index] or tag.layout
            end
        end
    },
}
