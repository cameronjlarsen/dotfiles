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
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                    "${3rd}/luassert/library"
                },
            },
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
            }
        },
    },
}
