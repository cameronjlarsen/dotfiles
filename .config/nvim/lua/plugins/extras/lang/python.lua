return {
    "mfussenegger/nvim-dap",
    cond = not vim.g.vscode,
    dependencies = {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        end,

    },
}
