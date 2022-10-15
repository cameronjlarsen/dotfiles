local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "vim" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "vim" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
