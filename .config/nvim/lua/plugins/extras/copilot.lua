local copilot_node_command = vim.fn.expand("$FNM_MULTISHELL_PATH")
-- if unix append "/bin/node"
-- if windows append "node.exe"
if vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1 then
    copilot_node_command = copilot_node_command .. "/bin/node"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    copilot_node_command = copilot_node_command .. "/node.exe"
end

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
            copilot_node_command = copilot_node_command
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
            table.insert(opts.sources, 3, { name = "copilot" })
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
