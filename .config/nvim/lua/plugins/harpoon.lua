return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>m"] = { name = "+Marks" },
            },
        },
    },
    {
        "ThePrimeagen/harpoon",   -- Per project, auto updating and editable marks utility for fast file navigation.
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>ma", function() require("harpoon.mark").add_file() end,              desc = "Add file to Harpoon" },
            { "<leader>mm", function() require("harpoon.ui").toggle_quick_menu() end,       desc = "Harpoon Quick Menu" },
            { "<leader>m.", function() require("harpoon.ui").nav_next() end,                desc = "Harpoon Next" },
            { "<leader>m,", function() require("harpoon.ui").nav_prev() end,                desc = "Harpoon Prev" },
            { "<leader>ms", function() require("telescope").extensions.harpoon.marks() end,
                                                                                                desc =
                "Harpoon Telescope Marks" },

        },
        config = function(_, opts)
            require("harpoon").setup(opts)
            require("telescope").load_extension("harpoon")
        end,
    }
}
