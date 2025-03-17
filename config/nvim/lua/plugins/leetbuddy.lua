-- LeetBuddy --
return {
    {
        "Dhanus3133/LeetBuddy.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim" },
        keys = {
            { "<leader>C", "",           desc = "+LeetBuddy" },
            { mode = "n",  "<leader>Cq", function() vim.cmd("LBQuestions") end, desc = "List Questions" },
            { mode = "n",  "<leader>Cc", function() vim.cmd("LBQuestion") end,  desc = "View Question" },
            { mode = "n",  "<leader>Cr", function() vim.cmd("LBReset") end,     desc = "Reset Code" },
            { mode = "n",  "<leader>Ct", function() vim.cmd("LBTest") end,      desc = "Run Code" },
            { mode = "n",  "<leader>Cs", function() vim.cmd("LBSubmit") end,    desc = "Submit Code" },

        },
        opts = {
            domain = "com",
            language = "py",
        }
    },
}
