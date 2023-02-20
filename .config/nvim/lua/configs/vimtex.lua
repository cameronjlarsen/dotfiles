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
