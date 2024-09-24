return {
    {
        "tamton-aquib/duck.nvim",
        cond = not vim.g.vscode,
        keys = {
            { "<leader>D",  "",                                     desc = "+Duck" },
            { "<leader>Dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
            { "<leader>Dk", function() require("duck").cook() end,  desc = "Cook a duck" },
        },
        opts = {
            character = "👻"
        }
    }
}
