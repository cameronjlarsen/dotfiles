return {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.vscode,
    dependencies =
    {
        "nvim-tree/nvim-web-devicons",
        "copilot-status.nvim"
    },
    event = "VeryLazy",
    opts = function()
        local components = require("plugins.lualine.components")

        return {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = "",
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "dashboard", "Outline", "lspinfo", "mason", "checkhealth", },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { components.mode },
                lualine_b = { components.filetype, components.filename, },
                lualine_c = { components.branch, components.diff },
                lualine_x = { components.diagnostics, components.treesitter, components.lsp, components.copilot },
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
        }
    end

}
