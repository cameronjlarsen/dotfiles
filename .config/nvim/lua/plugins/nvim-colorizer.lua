return {
    "NvChad/nvim-colorizer.lua",
    cmd = {
        "ColorizerToggle",
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers"
    },
    ft = { "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "lua" },
    opts = {
        user_default_options = {
            names = false,
            mode = "virtualtext",
        },
        filetypes = {
            "*",
            css = { css = true },
            sass = { css = true, tailwind = true },
        },
    },
}
