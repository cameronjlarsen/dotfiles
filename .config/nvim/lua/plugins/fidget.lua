return {
    "j-hui/fidget.nvim",
    cond = not vim.g.vscode,
    tag = "legacy",
    opts = {
        window = {
            blend = 0,
        },
    }
}
