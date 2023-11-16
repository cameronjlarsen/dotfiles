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
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
        background_colour = "#1E1E2E",
    },
    init = function()
        vim.notify = require("notify")
    end,
}
