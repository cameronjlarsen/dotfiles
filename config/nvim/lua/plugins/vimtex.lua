return {
    "lervag/vimtex",
    lazy = false,
    cond = not vim.g.vscode,
    ft = { "tex", "bib", "sty" },
    config = function(_, opts)
        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("vimtext_conceal", { clear = true }),
            pattern = { "bib", "tex" },
            callback = function()
                vim.wo.conceallevel = 2
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
