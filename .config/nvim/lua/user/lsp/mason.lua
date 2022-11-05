local icons = require("user.icons")

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    vim.notify("mason_lspconfig not loaded")
    return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    vim.notify("mason not loaded")
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("lspconfig not loaded")
    return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    vim.notify("null-ls not loaded")
    return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
    vim.notify("mason-null-ls not loaded")
    return
end

require("lspconfig.ui.windows").default_options.border = "rounded"

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

mason_null_ls.setup({
    ensure_installed = {
        "stylua",
        "java-debug-adapter",
        "java-test",
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

-- Setup mason null-ls sources
mason_null_ls.setup_handlers({
    function(source_name) end,
    stylua = function()
        null_ls.register(null_ls.builtins.formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
        }))
    end,
    flake8 = function()
        null_ls.register(null_ls.builtins.diagnostics.flake8)
    end,
})
