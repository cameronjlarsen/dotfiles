return {
    {
        "folke/which-key.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>D"] = { name = "+Duck", }
            },
        },
    },
    {
        "tamton-aquib/duck.nvim",
        cond = not vim.g.vscode,
        keys = {
            { "<leader>Dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
            { "<leader>Dk", function() require("duck").cook() end,  desc = "Cook a duck" },
        },
        opts = {
            character = "👻"
        }
    }
}
