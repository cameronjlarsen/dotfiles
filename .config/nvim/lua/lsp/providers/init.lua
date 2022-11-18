local deps_ok, mason_lspconfig, lspconfig = pcall(function()
    return require("mason-lspconfig"), require("lspconfig")
end)
if not deps_ok then
    return
end

require("lspconfig.ui.windows").default_options.border = "rounded"

mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
        "clangd",
        "jsonls",
        "texlab",
        "omnisharp",
        "bashls",
        "marksman",
        "sqlls",
        "jdtls",
    },
})

-- Setup servers with either the default or with custom settings defined in providers/[language].lua
mason_lspconfig.setup_handlers({
    function(server)
        local opts = {
            on_attach = require("lsp.providers.defaults").on_attach,
            capabilities = require("lsp.providers.defaults").capabilities,
        }
        local has_custom_opts, server_custom_opts = pcall(require, "lsp.providers." .. server)
        if has_custom_opts then
            opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
        end
        lspconfig[server].setup(opts)
    end,
    ["jdtls"] = function()
        lspconfig["jdtls"].setup(require("lsp.providers.jdtls"))
    end
})

require("lsp.providers.null-ls")
