return {
    {
        "folke/lazy.nvim",
        version = "*",
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeFocus", "UndotreeShow", "UndotreeHide" },
        keys = {
            { mode = { "n", "v" }, "<leader>fu", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
        },
    },
    {
        "moll/vim-bbye",
        cmd = { "Bdelete", "Bwipeout" },
        keys = {
            { "<leader>bc", function() vim.cmd("Bdelete!") end, desc = "Close Buffer" },
            { "<leader>bd", function() vim.cmd("Bdelete") end,  desc = "Delete Buffer" },
        },
    },
    {
        "numToStr/Navigator.nvim",
        opts = {},
        keys = {
            -- Navigate mux panes
            { "<A-h>", function() require("Navigator").left() end,  desc = "Navigate mux Pane Left" },
            { "<A-j>", function() require("Navigator").down() end,  desc = "Navigate mux Pane Down" },
            { "<A-k>", function() require("Navigator").up() end,    desc = "Navigate mux Pane Up" },
            { "<A-l>", function() require("Navigator").right() end, desc = "Navigate mux Pane Right" },
        },
    },
    {
        "theprimeagen/refactoring.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "neovim/nvim-lspconfig",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                            { text = { "%s" },                  click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    }
                end,
            },
        },
    }
}
