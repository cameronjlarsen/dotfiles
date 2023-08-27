return {
    keys = {
        { "<leader>lo", function() vim.cmd("TypescriptOrganizeImports") end, desc = "Organize Imports" },
        { "<leader>lR", function() vim.cmd("TypescriptRenameFile") end,      desc = "Rename File" },
    },
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
