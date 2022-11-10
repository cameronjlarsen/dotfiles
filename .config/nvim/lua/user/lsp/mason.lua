local icons = require("user.icons")
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    vim.notify("mason not loaded")
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = icons.dap.PackageInstalled,
            package_pending = icons.dap.PackagePending,
            package_uninstalled = icons.dap.PackageUninstalled,
        },
        border = "rounded"
    }
})

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
    end,
    ["jdtls"] = function()
        lspconfig["jdtls"].setup(require("user.lsp.settings.jdtls"))
    end
})
