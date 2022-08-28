-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
local gears     = require("gears")
local beautiful = require("beautiful")

local theme_dir = gears.filesystem.get_configuration_dir() .. "themes/"
beautiful.init(theme_dir .. "catppuccin/theme.lua")

-- Use bash for every shell cmd
require("awful").util.shell = "/bin/bash"

require("config")
require("widgets")
require("signals")
