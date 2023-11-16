return {
    "folke/noice.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        messages = {
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
        },
        lsp = {
            progress = {
                enabled = false,
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,            -- use a classic bottom cmdline for search
            command_palette = true,          -- position the cmdline and popupmenu together
            long_message_to_split = true,    -- long messages will be sent to a split
            inc_rename = true,               -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,          -- add a border to hover docs and signature help
            cmdline_output_to_split = false, -- send cmdline output to a split
        },
    },
}
