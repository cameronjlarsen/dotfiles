---------------------------
-- Catppuccin awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi
local gears        = require("gears")
local gfs          = require("gears.filesystem")
local config_path  = gfs.get_configuration_dir()
local icon_path    = config_path .. "icons/"
local walls_path   = "~/Pictures/Wallpapers/"
local catppuccin   = require("themes.catppuccin.colors")

local pallete = catppuccin.select("mocha")

local theme = {}

-- Colors
theme = {
    colors = {
        rosewater = pallete.rosewater,
        flamingo  = pallete.flamingo,
        pink      = pallete.pink,
        mauve     = pallete.mauve,
        red       = pallete.red,
        maroon    = pallete.maroon,
        peach     = pallete.peach,
        yellow    = pallete.yellow,
        green     = pallete.green,
        teal      = pallete.teal,
        sky       = pallete.sky,
        sapphire  = pallete.sapphire,
        blue      = pallete.blue,
        lavender  = pallete.lavender,
        text      = pallete.text,
        subtext1  = pallete.subtext1,
        subtext0  = pallete.subtext0,
        overlay2  = pallete.overlay2,
        overlay1  = pallete.overlay1,
        overlay0  = pallete.overlay0,
        surface2  = pallete.surface2,
        surface1  = pallete.surface1,
        surface0  = pallete.surface0,
        base      = pallete.base,
        mantle    = pallete.mantle,
        crust     = pallete.crust
    }
}

-- Wallpaper
theme.wallpaper = walls_path .. "evening-sky.png"

-- Default
theme.font_family = "Ubuntu "
theme.font        = theme.font_family .. 12
theme.font_italic = theme.font_family .. "Italic " .. 12
theme.font_icon   = "Material Icons Rounded "

theme.bg_normal   = theme.colors.base
theme.bg_focus    = theme.colors.base
theme.bg_urgent   = theme.colors.red
theme.bg_minimize = theme.colors.mantle

theme.fg_normal   = theme.colors.text
theme.fg_focus    = theme.colors.subtext0
theme.fg_urgent   = theme.colors.mantle
theme.fg_minimize = theme.colors.subtext0

-- Titlebar
theme.titlebar_bg_normal   = theme.colors.base
theme.titlebar_bg_focus    = theme.colors.base
theme.titlebar_bg_urgent   = theme.colors.mantle
theme.titlebar_bg_minimize = theme.colors.base

theme.titlebar_fg_normal   = theme.colors.text
theme.titlebar_fg_focus    = theme.colors.text
theme.titlebar_fg_urgent   = theme.colors.red
theme.titlebar_fg_minimize = theme.colors.text

-- Tasklist
theme.tasklist_bg_normal   = theme.colors.base
theme.tasklist_bg_focus    = theme.colors.lavender
theme.tasklist_bg_urgent   = theme.colors.surface0
theme.tasklist_bg_minimize = theme.colors.surface0

theme.tasklist_fg_normal   = theme.colors.subtext0
theme.tasklist_fg_focus    = theme.colors.text
theme.tasklist_fg_urgent   = theme.colors.maroon
theme.tasklist_fg_minimize = theme.colors.overlay1

theme.tasklist_font_minimized  = theme.font_italic
theme.tasklist_plain_task_name = true

-- Taglist
theme.taglist_bg_normal   = theme.colors.base
theme.taglist_bg_focus    = theme.colors.lavender
theme.taglist_bg_urgent   = theme.colors.maroon
theme.taglist_bg_minimize = theme.colors.overlay1
theme.taglist_bg_empty    = theme.colors.base
theme.taglist_bg_occupied = theme.colors.pink

theme.taglist_fg_normal   = theme.colors.text
theme.taglist_fg_focus    = theme.colors.crust
theme.taglist_fg_urgent   = theme.colors.crust
theme.taglist_fg_minimize = theme.colors.subtext0
theme.taglist_fg_empty    = theme.colors.overlay0
theme.taglist_fg_occupied = theme.colors.crust
theme.taglist_spacing     = dpi(10)
theme.taglist_shape       = gears.shape.rounded_rect
-- theme.taglist_shape_border_width_empty = dpi(2)
-- theme.taglist_shape_border_color_empty = theme.colors.blue

-- Wibar
theme.wibar_bg           = theme.colors.base
theme.wibar_container_bg = theme.colors.surface0

-- Tooltips
theme.tooltip_border_color = theme.colors.lavender
theme.tooltip_bg           = theme.bg_normal
theme.tooltop_fg           = theme.fg_normal
theme.tooltip_font         = theme.font
theme.tooltip_border_width = dpi(0)
theme.tooltip_gaps         = dpi(5)
theme.tooptip_shape        = gears.shape.rounded_rect

-- Menu
theme.menu_font         = theme.font
theme.menu_height       = dpi(40)
theme.menu_width        = dpi(150)
theme.menu_border_color = theme.colors.lavender
theme.menu_border_width = dpi(2)
theme.menu_fg_focus     = theme.colors.crust
theme.menu_bg_focus     = theme.colors.lavender
theme.menu_bg_normal    = theme.colors.surface0
theme.menu_fg_normal    = theme.colors.text

-- Misc
theme.useless_gap             = dpi(5)
theme.gap_single_client       = true
theme.border_width            = dpi(2)
theme.border_color_normal     = theme.colors.surface0
theme.border_color_active     = theme.colors.lavender
theme.border_color_urgent     = theme.colors.maroon
theme.border_radius           = dpi(5)
-- theme.bg_systray           = theme.wibar_container_bg
theme.systray_icon_spacing    = dpi(5)
theme.maximized_honor_padding = true

-- Hotkeys
theme.hotkeys_bg           = theme.colors.surface0
theme.hotkeys_fg           = theme.colors.text
theme.hotkeys_border_width = dpi(2)
theme.hotkeys_border_color = theme.colors.lavender
theme.hotkeys_modifiers_fg = theme.colors.green
theme.hotkeys_label_bg     = theme.colors.blue
theme.hotkeys_label_fg     = theme.colors.crust
theme.hotkeys_group_margin = dpi(15)

-- Notification spacing
theme.notification_font         = theme.font
theme.notification_border_width = dpi(3)
theme.notification_border_color = theme.border_color_active
theme.notification_shape        = gears.shape.rounded_rect
theme.notification_margin       = dpi(15)
theme.notification_spacing      = dpi(20)

-- Disable tooltips
theme.tooltop_opacity = 0

-- No taglist squares:
theme.taglist_squares_sel   = nil
theme.taglist_squares_unsel = nil

-- Define the image to load
theme.titlebar_close_button_normal = gears.surface.load_from_shape(50, 50, gears.shape.circle, theme.colors.red)
theme.titlebar_close_button_focus  = gears.surface.load_from_shape(50, 50, gears.shape.circle, theme.colors.red)

theme.titlebar_minimize_button_normal = gears.surface.load_from_shape(50, 50, gears.shape.circle, theme.colors.yellow)
theme.titlebar_minimize_button_focus  = gears.surface.load_from_shape(50, 50, gears.shape.circle, theme.colors.yellow)

theme.titlebar_maximized_button_normal_inactive = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    theme.colors.green)
theme.titlebar_maximized_button_focus_inactive  = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    theme.colors.green)
theme.titlebar_maximized_button_normal_active   = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    theme.colors.green)
theme.titlebar_maximized_button_focus_active    = gears.surface.load_from_shape(50, 50, gears.shape.circle,
    theme.colors.green)

-- You can use your own layout icons like this:
theme.layout_fairh      = gears.color.recolor_image(icon_path .. "layouts/fairhw.png", theme.fg_normal)
theme.layout_fairv      = gears.color.recolor_image(icon_path .. "layouts/fairvw.png", theme.fg_normal)
theme.layout_floating   = gears.color.recolor_image(icon_path .. "layouts/floatingw.png", theme.fg_normal)
theme.layout_magnifier  = gears.color.recolor_image(icon_path .. "layouts/magnifierw.png", theme.fg_normal)
theme.layout_max        = gears.color.recolor_image(icon_path .. "layouts/maxw.png", theme.fg_normal)
theme.layout_fullscreen = gears.color.recolor_image(icon_path .. "layouts/fullscreenw.png", theme.fg_normal)
theme.layout_tilebottom = gears.color.recolor_image(icon_path .. "layouts/tilebottomw.png", theme.fg_normal)
theme.layout_tileleft   = gears.color.recolor_image(icon_path .. "layouts/tileleftw.png", theme.fg_normal)
theme.layout_tile       = gears.color.recolor_image(icon_path .. "layouts/tilew.png", theme.fg_normal)
theme.layout_tiletop    = gears.color.recolor_image(icon_path .. "layouts/tiletopw.png", theme.fg_normal)
theme.layout_spiral     = gears.color.recolor_image(icon_path .. "layouts/spiralw.png", theme.fg_normal)
theme.layout_dwindle    = gears.color.recolor_image(icon_path .. "layouts/dwindlew.png", theme.fg_normal)
theme.layout_cornernw   = gears.color.recolor_image(icon_path .. "layouts/cornernww.png", theme.fg_normal)
theme.layout_cornerne   = gears.color.recolor_image(icon_path .. "layouts/cornernew.png", theme.fg_normal)
theme.layout_cornersw   = gears.color.recolor_image(icon_path .. "layouts/cornersww.png", theme.fg_normal)
theme.layout_cornerse   = gears.color.recolor_image(icon_path .. "layouts/cornersew.png", theme.fg_normal)

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.colors.crust, theme.colors.text)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Catppuccin-SE"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
