return {
    on_attach = function(client, bufnr)
        require("plugins.lsp.defaults").on_attach(client, bufnr)
        local map = Utils.map
        map("n", "<leader>lo",
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        only = { "source.organizeImports.ts" },
                        diagnostics = {},
                    }
                })
            end,
            { desc = "Organize Imports" })
        map("n", "<leader>lR", function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                },
            })
        end, { desc = "Remove Unused Imports" })
    end,
    settings = {
        typescript = {
            format = {
                indentSize = vim.o.shiftwidth,
                conrvertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
            },
        },
        javascript = {
            format = {
                indentSize = vim.o.shiftwidth,
                conrvertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
            },
        },
        completions = {
            completeFunctionCalls = true,
        },
    },
}
