local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    print("mason_lspconfig not loaded")
    return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    print("mason not loaded")
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    print("lspconfig not loaded")
    return
end

require("lspconfig.ui.windows").default_options.border = "rounded"


mason.setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
        border = "rounded"
    }
})

mason_lspconfig.setup({
    ensure_installed = { "sumneko_lua", "clangd", "jsonls", "texlab", "omnisharp", "bashls", "marksman", "sqlls",
    },
})

-- Setup servers with either the default or with custom settings defined in settings/lang.lua
mason_lspconfig.setup_handlers({
    function(server)
        local opts = {
            on_attach = require("user.lsp.handlers").on_attach,
            capabilities = require("user.lsp.handlers").capabilities,
        }
        local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
        if has_custom_opts then
            opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
        end
        lspconfig[server].setup(opts)
    end
})
