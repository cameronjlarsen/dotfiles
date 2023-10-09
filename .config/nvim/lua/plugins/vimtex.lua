return {
    "lervag/vimtex",
    cond = not vim.g.vscode,
    ft = "tex",
    config = function(_, opts)
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = opts.pattern,
            callback = function()
                vim.cmd("VimtexCompile")
            end,
        })
        vim.g.vimtex_view_method = "sioyek"
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = "-xelatex"
        }
        vim.g.tex_comment_nospell = 1
        vim.g.vimtex_compiler_progname = "nvr"
        vim.g.vimtex_quickfix_ignore_filters = {
            "Underfull",
            "Overfull",
            "Negative"
        }
        vim.g.vimtex_mappings_prefix = "<leader>v"
        vim.g.vimtex_fold_enabled = true
    end,
}
