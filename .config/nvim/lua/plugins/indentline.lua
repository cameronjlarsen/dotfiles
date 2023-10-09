return {
    "lukas-reineke/indent-blankline.nvim",
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            smart_indent_cap = true,
            priority = 2,
        },
        scope = {
            char = "│",
            show_start = false,
            show_end = false,
            injected_languages = true,
            priority = 1000,
            highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            },
            include = {
                node_type = {
                    lua = {
                        'chunk',
                        'do_statement',
                        'while_statement',
                        'repeat_statement',
                        'if_statement',
                        'for_statement',
                        'function_declaration',
                        'function_definition',
                        'table_constructor',
                        'assignment_statement',
                    },
                    typescript = {
                        'statement_block',
                        'function',
                        'arrow_function',
                        'function_declaration',
                        'method_definition',
                        'for_statement',
                        'for_in_statement',
                        'catch_clause',
                        'object_pattern',
                        'arguments',
                        'switch_case',
                        'switch_statement',
                        'switch_default',
                        'object',
                        'object_type',
                        'ternary_expression',
                    },
                },
            }
        },
        exclude = {
            buftypes = { "terminal", "nofile" },
            filetypes = {
                "help",
                "startify",
                "alpha",
                "dashboard",
                "packer",
                "neogitstatus",
                "NvimTree",
                "neo-tree",
                "lazy",
                "mason",
                "notify",
                "Trouble",
            },

        },
    },
    config = function(_, opts)
        local hooks = require "ibl.hooks"
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_space_indent_level
        )
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_tab_indent_level
        )

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        require("ibl").setup(opts)
    end
}
