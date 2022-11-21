local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local components = require("configs.lualine.components")

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "Outline", "lspinfo", "mason", "checkhealth", },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { components.mode },
        lualine_b = { components.filetype, components.filename, },
        lualine_c = { components.branch, components.diff },
        lualine_x = { components.diagnostics, components.lsp },
        lualine_y = { components.spaces },
        lualine_z = { components.progress },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { components.filetype, components.filename },
        lualine_x = { components.progress },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
