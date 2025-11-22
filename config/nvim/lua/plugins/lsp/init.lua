return {
    {
        "neovim/nvim-lspconfig",
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim",                           cmd = "Neoconf",                                                   config = false, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim",                            opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", opts = {} },
            { "mfussenegger/nvim-jdtls" },
            { "seblj/roslyn.nvim" },
        },
        keys = {
            { "<leader>li", function() vim.cmd("LspInfo") end, silent = true, desc = "LSP Info" },
        },
        opts = function()
            local icons = {
                diagnostics = require("core.icons").get("diagnostics")
            }

            -- Configure diagnostic signs using modern API
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                        [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                    }
                }
            })
            return {
                diagnostics = {
                    virtual_text = false,
                    virtual_lines = true,
                    update_in_insert = false,
                    underline = true,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        style     = "minimal",
                        border    = "rounded",
                        source    = "always",
                        header    = "",
                        prefix    = "",
                    },
                },
                inlay_hints  = {
                    enabled = true,
                },
                ui           = {
                    windows = {
                        default_options = {
                            border = "rounded",
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cond = not vim.g.vscode,
        cmd = { "LspInstall", "LspUninstall" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
                "jsonls",
                "texlab",
                "bashls",
                "marksman",
                "jdtls",
                "ts_ls"
            },
            handlers = {
                function(server)
                    local opts = require("plugins.lsp.defaults").default_config
                    local has_custom_provider, custom_config = pcall(require, "plugins.lsp.providers." .. server)
                    if has_custom_provider then
                        opts = vim.tbl_deep_extend("force", opts, custom_config)
                    end
                    require("lspconfig")[server].setup(opts)
                end,
                ["jdtls"] = function()
                    require("lspconfig")["jdtls"].setup(require("plugins.lsp.providers.jdtls"))
                end,
            }
        }
    },
    { import = "plugins.languages" },
}
