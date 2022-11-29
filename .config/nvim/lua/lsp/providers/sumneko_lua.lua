return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                },
            },
            completion = {
                keywordSnippet = "Replace",
                callSnippet = "Replace",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config")] = true,
                },
                maxPreload = 5000,
                preloadFileSize = 10000,
            },
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
            },
            hint = {
                enable = true,
            },
        },
    },
}
