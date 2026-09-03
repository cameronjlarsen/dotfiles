local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

local os_detection = require("utils.os_detection")
local current_os = os_detection.get_current_os()

local modules = {
    "colors.catppuccin",
    "config.appearance",
    "config.fonts",
    "config.general",
    "config.keybinds",
    "config.hyperlinks",

    "events.pane_navigation",
    "events.tab_bar",
    "events.status_bar",
}

-- Add OS-specific config
if current_os == "Windows" then
    table.insert(modules, "os.windows")
elseif current_os == "Darwin" then
    table.insert(modules, "os.macos")
elseif current_os == "Linux" then
    table.insert(modules, "os.linux")
end

for _, module_name in ipairs(modules) do
    local ok, module = pcall(require, module_name)
    if ok then
        config = module(config)
    else
        wezterm.log_error("Failed to load module: " .. module_name)
    end
end

return config

