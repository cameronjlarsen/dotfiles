return {
    {
        "folke/which-key.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>l"] = {
                    name = "+LSP",
                    w = { name = "+Workspace" },
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {
                    library = {
                        plugins =
                        {
                            "nvim-dap-ui",
                        },
                        types = true
                    },
                }
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                opts = {},
            },
            "mfussenegger/nvim-jdtls"
        },
        keys = {
            { "<leader>li", function() vim.cmd("LspInfo") end, silent = true, desc = "LSP Info" },
        },
        opts = function()
            local icons = {
                diagnostics = require("core.icons").get("diagnostics")
            }

            local signs = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warn },
                { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo",  text = icons.diagnostics.Info },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end
            return {
                diagnoistics = {
                    virtual_text = false,
                    virtual_lines = true,
                    signs = {
                        active = signs
                    },
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
                "omnisharp_mono",
                "bashls",
                "marksman",
                "jdtls",
                "gopls",
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
    {
        "lvimuser/lsp-inlayhints.nvim",
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile" },
    },
}
