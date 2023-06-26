return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {},              -- global options for the cmdline. See section on views
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
            command_palette = false,         -- position the cmdline and popupmenu together
            long_message_to_split = true,    -- long messages will be sent to a split
            inc_rename = false,              -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,          -- add a border to hover docs and signature help
            cmdline_output_to_split = false, -- send cmdline output to a split
        },
    },
}
