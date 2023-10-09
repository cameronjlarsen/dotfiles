return {
    "rcarriga/nvim-notify",
    cond = not vim.g.vscode,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("notify")
        end
    },
    opts = {
        background_colour = "#1E1E2E",
    },
    init = function()
        vim.notify = require("notify")
    end,
}
