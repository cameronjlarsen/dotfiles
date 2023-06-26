return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>g"] = { name = "+Git" },
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { "<leader>gg", function() require("lazygit").lazygitcurrentfile() end,           desc = "LazyGit" },
            { "<leader>gr", function() require("telescope").extensions.lazygit.lazygit() end, desc = "LazyGit Repos" },
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
}
