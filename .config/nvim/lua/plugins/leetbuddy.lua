-- LeetBuddy --
return {
    {
        "folke/which-key.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>c"] = { name = "+LeetCode" },
            },
        },
    },
    {
        "Dhanus3133/LeetBuddy.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim" },
        keys = {
            { mode = "n", "<leader>cq", function() vim.cmd("LBQuestions") end, desc = "List Questions" },
            { mode = "n", "<leader>cc", function() vim.cmd("LBQuestion") end,  desc = "View Question" },
            { mode = "n", "<leader>cr", function() vim.cmd("LBReset") end,     desc = "Reset Code" },
            { mode = "n", "<leader>ct", function() vim.cmd("LBTest") end,      desc = "Run Code" },
            { mode = "n", "<leader>cs", function() vim.cmd("LBSubmit") end,    desc = "Submit Code" },

        },
        opts = {
            domain = "com",
            language = "py",
        }
    },
}
