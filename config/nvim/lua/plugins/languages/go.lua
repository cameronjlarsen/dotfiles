return {
    "mfussenegger/nvim-dap",
    cond = not vim.g.vscode,
    dependencies = {
        "leoluz/nvim-dap-go",
        opts = {},
    },
}
