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
        local defaults = require("lsp.providers.defaults").default_config
        local has_custom_provider, custom_config = pcall(require, "lsp.providers." .. server)
        if has_custom_provider then
            defaults = vim.tbl_deep_extend("force", defaults, custom_config)
        end
        lspconfig[server].setup(defaults)
    end,
    ["jdtls"] = function()
        lspconfig["jdtls"].setup(require("lsp.providers.jdtls"))
    end,
})

-- Setup null-ls
require("lsp.providers.null-ls")
require("lsp.providers.copilot")
require("lsp.diagnoistics")
require("lsp.handlers")
