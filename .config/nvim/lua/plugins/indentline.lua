return {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
        char = "┆",
        context_char = "│",
        space_char_blankline = " ",
        show_first_indent_level = false,
        show_trailing_blankline_indent = false,
        show_end_of_line = true,
        show_current_context = true,
        show_current_context_start = false,
        use_treesitter = true,
        context_highlight_list = {
            "IndentBlanklineIndent6",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent1",
        },
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = {
            "help",
            "startify",
            "dashboard",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
        },
        context_patterns = {
            "class",
            "return",
            "function",
            "method",
            "^if",
            "^while",
            "jsx_element",
            "^for",
            "^object",
            "^table",
            "block",
            "arguments",
            "if_statement",
            "else_clause",
            "jsx_element",
            "jsx_self_closing_element",
            "try_statement",
            "catch_clause",
            "import_statement",
            "operation_type",
        },
    }
}
