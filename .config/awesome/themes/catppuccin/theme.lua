---------------------------
-- Catppuccin awesome theme --
---------------------------

local theme_assets              = require("beautiful.theme_assets")
local xresources                = require("beautiful.xresources")
local dpi                       = xresources.apply_dpi
local gears                     = require("gears")
local gfs                       = require("gears.filesystem")
local config_path               = gfs.get_configuration_dir()
local icon_path                 = config_path .. "icons/"
local walls_path                = "~/Pictures/Wallpapers/"
local catppuccin                = require("themes.catppuccin.colors")

local color                     = catppuccin.select("mocha")

local theme                     = {}

-- Wallpaper
theme.wallpaper                 = walls_path .. "lawson.jpg"

-- Default
theme.font_family               = "Ubuntu "
theme.font                      = theme.font_family .. 12
theme.font_italic               = theme.font_family .. "Italic " .. 12
theme.font_icon                 = "Material Icons Rounded "

theme.bg_normal                 = color.base
theme.bg_focus                  = color.base
theme.bg_urgent                 = color.red
theme.bg_minimize               = color.mantle

theme.fg_normal                 = color.text
theme.fg_focus                  = color.subtext0
theme.fg_urgent                 = color.mantle
theme.fg_minimize               = color.subtext0

-- Bling
theme.flash_focus_start_opacity = 0.6
theme.flash_focus_step          = 0.01

theme.tabbed_spawn_in_tab       = true
theme.tabbar_disable            = true
theme.tabbar_ontop              = false
theme.tabbar_radius             = dpi(10)
theme.tabbar_style              = "modern"
theme.tabbar_font               = theme.font
theme.tabbar_size               = dpi(35)
theme.tabbar_position           = "top"
theme.tabbar_bg_normal          = color.base
theme.tabbar_fg_normal          = color.text
theme.tabbar_bg_focus           = color.surface1
theme.tabbar_fg_focus           = color.text
theme.tabbar_bg_focus_inactive  = nil
theme.tabbar_fg_focus_inactive  = nil
theme.tabbar_bg_normal_inactive = nil
theme.tabbar_fg_normal_inactive = nil
theme.tabbar_color_close        = color.red
theme.tabbar_color_min          = color.yellow
theme.tabbar_color_float        = color.green


-- Titlebar
theme.titlebar_bg_normal                        = color.base
theme.titlebar_bg_focus                         = color.base
theme.titlebar_bg_urgent                        = color.mantle
theme.titlebar_bg_minimize                      = color.base

theme.titlebar_fg_normal                        = color.text
theme.titlebar_fg_focus                         = color.text
theme.titlebar_fg_urgent                        = color.red
theme.titlebar_fg_minimize                      = color.text

-- Tasklist
theme.tasklist_bg_normal                        = color.base
theme.tasklist_bg_focus                         = color.lavender
theme.tasklist_bg_urgent                        = color.surface0
theme.tasklist_bg_minimize                      = color.surface0

theme.tasklist_fg_normal                        = color.subtext0
theme.tasklist_fg_focus                         = color.text
theme.tasklist_fg_urgent                        = color.maroon
theme.tasklist_fg_minimize                      = color.overlay1

theme.tasklist_font_minimized                   = theme.font_italic
theme.tasklist_plain_task_name                  = true

-- Taglist
theme.taglist_bg_normal                         = color.base
theme.taglist_bg_focus                          = color.lavender
theme.taglist_bg_urgent                         = color.maroon
theme.taglist_bg_minimize                       = color.overlay1
theme.taglist_bg_empty                          = color.surface0
theme.taglist_bg_occupied                       = color.pink

theme.taglist_fg_normal                         = color.text
theme.taglist_fg_focus                          = color.crust
theme.taglist_fg_urgent                         = color.crust
theme.taglist_fg_minimize                       = color.subtext0
theme.taglist_fg_empty                          = color.overlay0
theme.taglist_fg_occupied                       = color.crust
theme.taglist_spacing                           = dpi(10)
theme.taglist_shape                             = gears.shape.rounded_rect
-- theme.taglist_shape_border_width_empty = dpi(2)
-- theme.taglist_shape_border_color_empty = color.blue

-- Wibar
theme.wibar_bg                                  = color.base
theme.wibar_container_bg                        = color.surface0
theme.wibar_container_border                    = color.surface0
theme.wibar_height                              = dpi(40)
theme.wibar_margin                              = { top = dpi(5), bottom = dpi(0), left = dpi(10), right = dpi(10) }

-- Tooltips
theme.tooltip_border_color                      = color.lavender
theme.tooltip_bg                                = theme.bg_normal
theme.tooltop_fg                                = theme.fg_normal
theme.tooltip_font                              = theme.font
theme.tooltip_border_width                      = dpi(0)
theme.tooltip_gaps                              = dpi(5)
theme.tooptip_shape                             = gears.shape.rounded_rect

-- Menu
theme.menu_font                                 = theme.font
theme.menu_height                               = dpi(40)
theme.menu_width                                = dpi(150)
theme.menu_border_color                         = color.lavender
theme.menu_border_width                         = dpi(2)
theme.menu_fg_focus                             = color.crust
theme.menu_bg_focus                             = color.lavender
theme.menu_bg_normal                            = color.surface0
theme.menu_fg_normal                            = color.text

-- Misc
theme.useless_gap                               = dpi(5)
theme.gap_single_client                         = true
theme.border_width                              = dpi(2)
theme.border_width_maximized                    = dpi(2)
theme.border_color_normal                       = color.surface0
theme.border_color_active                       = color.lavender
theme.border_color_urgent                       = color.maroon
theme.border_color_maximized                    = color.green
theme.border_color_tabbed                       = color.red
theme.border_radius                             = dpi(5)
theme.bg_systray                                = theme.wibar_container_bg
theme.systray_icon_spacing                      = dpi(8)
theme.systray_max_rows                          = 5
theme.maximized_honor_padding                   = true
theme.tray_chevron_up                           = gears.color.recolor_image(icon_path .. "chevron_up.svg",
    theme.fg_normal)
theme.tray_chevron_down                         = gears.color.recolor_image(icon_path .. "chevron_down.svg",
    theme.fg_normal)

-- Hotkeys
theme.hotkeys_bg                                = color.surface0
theme.hotkeys_fg                                = color.text
theme.hotkeys_border_width                      = dpi(2)
theme.hotkeys_border_color                      = color.lavender
theme.hotkeys_modifiers_fg                      = color.green
theme.hotkeys_label_bg                          = color.blue
theme.hotkeys_label_fg                          = color.crust
theme.hotkeys_group_margin                      = dpi(15)

-- Notification spacing
theme.notification_font                         = theme.font
theme.notification_border_width                 = dpi(3)
theme.notification_border_color                 = theme.border_color_active
theme.notification_shape                        = gears.shape.rounded_rect
theme.notification_margin                       = dpi(15)
theme.notification_spacing                      = dpi(20)
theme.fallback_notif_icon                       = gears.color.recolor_image(icon_path .. "info.svg",
    color.lavender)

-- Disable tooltips
theme.tooltop_opacity                           = 0

-- No taglist squares:
theme.taglist_squares_sel                       = nil
theme.taglist_squares_unsel                     = nil

-- Taglist Preview
theme.tag_preview_widget_border_radius          = dpi(5) * 2                -- Border radius of the widget (With AA)
theme.tag_preview_client_border_radius          = dpi(5)                    -- Border radius of each client in the widget (With AA)
theme.tag_preview_client_opacity                = 0.5                       -- Opacity of each client
theme.tag_preview_client_bg                     = theme.bg_normal           -- The bg color of each client
theme.tag_preview_client_border_color           = theme.border_color_active -- The border color of each client
theme.tag_preview_client_border_width           = theme.border_width        -- The border width of each client
theme.tag_preview_widget_bg                     = theme.bg_normal           -- The bg color of the widget
theme.tag_preview_widget_border_color           = theme.border_color_active -- The border color of the widget
theme.tag_preview_widget_border_width           = theme.border_width        -- The border width of the widget
theme.tag_preview_widget_margin                 = theme.useless_gap         -- The margin of the widget

-- Define the image to load
theme.titlebar_close_button_normal              = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.red)
theme.titlebar_close_button_focus               = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.red)

theme.titlebar_minimize_button_normal           = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.yellow)
theme.titlebar_minimize_button_focus            = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.yellow)

theme.titlebar_maximized_button_normal_inactive = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.green)
theme.titlebar_maximized_button_focus_inactive  = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.green)
theme.titlebar_maximized_button_normal_active   = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.green)
theme.titlebar_maximized_button_focus_active    = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    color.green)

-- You can use your own layout icons like this:
theme.layout_fairh                              = gears.color.recolor_image(icon_path .. "layouts/fairhw.png",
    theme.fg_normal)
theme.layout_fairv                              = gears.color.recolor_image(icon_path .. "layouts/fairvw.png",
    theme.fg_normal)
theme.layout_floating                           = gears.color.recolor_image(icon_path .. "layouts/floatingw.png",
    theme.fg_normal)
theme.layout_magnifier                          = gears.color.recolor_image(icon_path .. "layouts/magnifierw.png",
    theme.fg_normal)
theme.layout_max                                = gears.color.recolor_image(icon_path .. "layouts/maxw.png",
    theme.fg_normal)
theme.layout_fullscreen                         = gears.color.recolor_image(icon_path .. "layouts/fullscreenw.png",
    theme.fg_normal)
theme.layout_tilebottom                         = gears.color.recolor_image(icon_path .. "layouts/tilebottomw.png",
    theme.fg_normal)
theme.layout_tileleft                           = gears.color.recolor_image(icon_path .. "layouts/tileleftw.png",
    theme.fg_normal)
theme.layout_tile                               = gears.color.recolor_image(icon_path .. "layouts/tilew.png",
    theme.fg_normal)
theme.layout_tiletop                            = gears.color.recolor_image(icon_path .. "layouts/tiletopw.png",
    theme.fg_normal)
theme.layout_spiral                             = gears.color.recolor_image(icon_path .. "layouts/spiralw.png",
    theme.fg_normal)
theme.layout_dwindle                            = gears.color.recolor_image(icon_path .. "layouts/dwindlew.png",
    theme.fg_normal)
theme.layout_cornernw                           = gears.color.recolor_image(icon_path .. "layouts/cornernww.png",
    theme.fg_normal)
theme.layout_cornerne                           = gears.color.recolor_image(icon_path .. "layouts/cornernew.png",
    theme.fg_normal)
theme.layout_cornersw                           = gears.color.recolor_image(icon_path .. "layouts/cornersww.png",
    theme.fg_normal)
theme.layout_cornerse                           = gears.color.recolor_image(icon_path .. "layouts/cornersew.png",
    theme.fg_normal)

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(theme.menu_height, color.crust,
    color.text)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = "Catppuccin-SE"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
