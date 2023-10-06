return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            panel = {
                enabled = false,
                auto_refresh = true,
                keymap = {
                    accept = "<CR>",
                    jump_prev = "[[",
                    jump_next = "]]",
                    refresh = "gr",
                    open = "<M-CR>"
                },
            },
            suggestion = {
                enabled = false,
                auto_trigger = true,
                debounce = 50,
                keymap = {
                    accept = false,
                    accept_word = "<M-Right>",
                    accept_line = "<M-Down>",
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<M-h>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = 'node', -- Node version must be < 18
            plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
            server_opts_overrides = {
                trace = "verbose",
                settings = {
                    advanced = {
                        listCount = 10,
                        inlineSuggestCount = 3,
                    },
                }
            },
        }
    },
    {
        "nvim-cmp",
        dependencies = {
            "zbirenbaum/copilot-cmp",
            dependencies = "copilot.lua",
            opts = {},
            config = function(_, opts)
                require("copilot_cmp").setup(opts)
            end,
        },
        opts = function(_, opts)
            local cmp = require("cmp")

            table.insert(opts.sources, 4, { name = "copilot" })

            opts.sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    require("copilot_cmp.comparators").score,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            }
        end
    }
}
