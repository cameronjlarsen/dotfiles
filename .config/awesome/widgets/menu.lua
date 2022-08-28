local awful         = require("awful")
local apps          = require("config.apps")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local menu = {}

-- Create a launcher widget and a main menu
menu.awesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", apps.terminal .. " -e man awesome" },
    { "Config", apps.text_editor .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

menu.rootmenu = awful.menu({
    items = {
        { "Awesome", menu.awesomemenu },
        { "Terminal", apps.terminal },
        { "Browser", apps.web_browser },
        { "Files", apps.file_manager },
        { "Nvim", apps.text_editor },
    }
})

menu.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = menu.rootmenu
})

-- Sets the menu and submenus to have rounded corners
-- menu.rootmenu.wibox.shape = function(cr, w, h)
--     gears.shape.rounded_rect(cr, w, h, 10)
-- end
--
-- awful.menu.original_new = awful.menu.new
-- function awful.menu.new(...)
--     local ret = awful.menu.original_new(...)
--     ret.wibox.shape = function(cr, w, h)
--         gears.shape.rounded_rect(cr, w, h, 10)
--     end
--     return ret
-- end

return menu
