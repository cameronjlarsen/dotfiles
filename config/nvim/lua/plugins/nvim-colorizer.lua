return {
    "NvChad/nvim-colorizer.lua",
    cond = not vim.g.vscode,
    cmd = {
        "ColorizerToggle",
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers"
    },
    ft = { "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "lua" },
    opts = {
        user_default_options = {
            mode = "virtualtext",
            tailwind = true,
        }
    },
}
