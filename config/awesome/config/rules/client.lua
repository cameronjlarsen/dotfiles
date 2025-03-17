local awful = require("awful")
local ruled = require("ruled")

-- Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        id         = "Android Emulator",
        rule_any   = {
            name = { "Emulator" }
        },
        properties = {
            floating          = true,
            ontop             = true,
            size_hints_honor  = false,
            height            = 1000,
            width             = 600,
            titlebars_enabled = false,
            border_width      = 0,
        },
        callback   = function(c)
            awful.placement.no_offscreen(c, { honor_workarea = true })
            awful.placement.align(c, { position = "top_right" })
            awful.titlebar.hide(c)
        end
    }

    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = {},
        properties = {
            focus             = awful.client.focus.filter,
            raise             = true,
            size_hints_honor  = false,
            screen            = awful.screen.preferred,
            titlebars_enabled = true,
            placement         = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen
        },
    }


    -- Floating clients.
    ruled.client.append_rule {
        id         = "floating",
        rule_any   = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "Redshift-gtk",
                "Nm-connection-editor", "Yad", "Lxappearance", "pavucontrol", "Pavucontrol",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name     = {
                "Event Tester", -- xev.
                "Capture Launcher",
                "PayPal Checkout - Review your payment - Mozilla Firefox",
                "Library",
                "Friends List",
                "Steam - News",
                "tdropdropdown",
                "Android Emulator"
            },
            role     = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            },
            type     = { "splash", "dialog" }
        },
        properties = {
            floating  = true,
            placement = awful.placement.centered + awful.placement.no_offscreen
        }
    }

    -- VirtualBox
    ruled.client.append_rule {
        id         = "virtualbox",
        rule_any   = {
            class = { "VirtualBox" },
        },
        except_any = {
            class = { "VirtualBox Manager", "VirtualBox Machine" }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered
        }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
    }
end)
