return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            {
                "theprimeagen/refactoring.nvim",
                dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
                opts = {},
            }
        },
        keys = {
            { "<leader>ln", function() vim.cmd("NullLsInfo") end, silent = true, desc = "Null-Ls Info" },
        },
        opts = function()
            local nls = require("null-ls")
            return {
                on_attach = require("plugins.lsp.defaults").on_attach,
                sources = {
                    nls.builtins.code_actions.gitsigns,
                    nls.builtins.code_actions.refactoring,
                    nls.builtins.formatting.google_java_format,
                    nls.builtins.formatting.latexindent,
                    nls.builtins.diagnostics.zsh,
                    nls.builtins.hover.dictionary,
                    nls.builtins.hover.printenv,
                },
            }
        end,


    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        opts = function()
            local nls = require("null-ls")
            local function with_root_file(...)
                local files = { ... }
                return function(utils)
                    return utils.root_has_file(files)
                end
            end

            return {
                ensure_installed = {
                    "stylua",
                },
                handlers = {
                    function(source_name, methods)
                        require("mason-null-ls.automatic_setup")(source_name, methods)
                    end,
                    stylua = function()
                        nls.register(nls.builtins.formatting.stylua.with({
                            condition = with_root_file({ "stylua.toml", ".stylua.toml" }),
                        }))
                    end,
                    flake8 = function()
                        nls.register(nls.builtins.diagnostics.flake8)
                    end,
                    clang_format = function()
                        nls.register(nls.builtins.formatting.clang_format.with({
                            disabled_filetypes = { "java", "cs" }
                        }))
                    end,
                    cbfmt = function()
                        nls.register(nls.builtins.formatting.cbfmt.with({
                            condition = with_root_file(".cbfmt.toml"),
                            extra_filetypes = { "pandoc" }
                        }))
                    end,
                    sql_formatter = function()
                        nls.register(nls.builtins.formatting.sql_formatter.with({
                            extra_args = { "--language", "postgres" },
                        }))
                    end,
                    prettierd = function()
                        nls.register(nls.builtins.formatting.prettierd.with({
                            extra_filetypes = { "pandoc" }
                        }))
                    end,
                }
            }
        end,
    }
}
