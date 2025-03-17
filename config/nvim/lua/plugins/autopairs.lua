return {
    "windwp/nvim-autopairs",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    opts = {
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
    config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        require("cmp").event:on("confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done {
                map_char = {
                    tex = ""
                }
            })

        local Rule = require("nvim-autopairs.rule")
        require("nvim-autopairs").add_rule(
            Rule("$", "$", { "tex", "latex", "md", "markdown" })
            :with_move(function(options)
                return options.next_char == options.char
            end)
        )
    end

}
