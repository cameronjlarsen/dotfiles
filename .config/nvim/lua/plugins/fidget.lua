return {
    "j-hui/fidget.nvim",
    cond = not vim.g.vscode,
    opts = {
        notification = {
            window = {
                winblend = 0,
            },
        }
    }
}
