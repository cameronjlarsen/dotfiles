return {
    {
        "zbirenbaum/copilot.lua",
        cond = not vim.g.vscode,
        event = "BufReadPost",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
            },
            filetypes = {
                markdown = true,
                help = true,
            },
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        opts = function(_, opts)
            local components = require("plugins.lualine.components")
            table.insert(opts.sections.lualine_x, 4, components.copilot)
        end,

    },
    {
        "nvim-cmp",
        cond = not vim.g.vscode,
        dependencies = {
            "zbirenbaum/copilot-cmp",
            dependencies = "copilot.lua",
            event = "BufReadPost",
            opts = true,
            config = function(_, opts)
                local copilot_cmp = require("copilot_cmp")

                copilot_cmp.setup(opts)

                -- attach cmp source whenever copilot attaches
                -- fixes lazy loading issues with copilot cmp source
                require("core.utils").on_attach(function(client, _)
                    if client.name ~= "copilot" then
                        copilot_cmp._on_insert_enter({})
                    end
                end)
            end,
        },
        opts = function(_, opts)
            table.insert(opts.sources, 1, { name = "copilot", group_index = 1 })
        end
    },
    {
        "jonahgoldwastaken/copilot-status.nvim",
        dependencies = { "copilot.lua" }, -- or "zbirenbaum/copilot.lua"
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            icons = {
                idle = " ",
                error = " ",
                offline = " ",
                warning = " ",
                loading = " ",
            },
            debug = true,
        },
    }
}
