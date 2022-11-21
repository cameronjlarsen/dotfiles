local cp = require("catppuccin.palettes").get_palette()
local config = require("catppuccin").options
local catppuccin = {}

local transparent_bg = config.transparent_background and "NONE" or cp.mantle

catppuccin.normal = {
    a = { bg = cp.blue, fg = cp.mantle, gui = "bold" },
    b = { bg = cp.surface1, fg = cp.text },
    c = { bg = transparent_bg, fg = cp.text },
}

catppuccin.insert = {
    a = { bg = cp.green, fg = cp.base, gui = "bold" },
    b = { bg = cp.surface1, fg = cp.text },
}

catppuccin.command = {
    a = { bg = cp.peach, fg = cp.base, gui = "bold" },
    b = { bg = cp.surface1, fg = cp.peach },
}

catppuccin.visual = {
    a = { bg = cp.flamingo, fg = cp.base, gui = "bold" },
    b = { bg = cp.surface1, fg = cp.rosewater },
}

catppuccin.replace = {
    a = { bg = cp.maroon, fg = cp.base, gui = "bold" },
    b = { bg = cp.surface1, fg = cp.red },
}

catppuccin.inactive = {
    a = { bg = transparent_bg, fg = cp.lavender },
    b = { bg = transparent_bg, fg = cp.surface1, gui = "bold" },
    c = { bg = transparent_bg, fg = cp.overlay0 },
}

return catppuccin
