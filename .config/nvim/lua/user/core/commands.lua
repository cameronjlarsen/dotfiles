---@diagnostic disable: assign-type-mismatch
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.keymap.set("n", "<silent> <buffer> q", ":close<CR>")
        vim.opt.buflisted = false
    end,
})

autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

autocmd({ "FileType" }, {
    pattern = "markdown",
    callback = function()
        vim.opt_local.autowriteall = true
    end
})

autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
})

autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

autocmd("FileType", {
    pattern = "dap-repl",
    callback = function(args)
        vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
    end,
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_group = augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerSync",
    pattern = "packer.lua",
    group = packer_group,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
        vim.notify_once("Compile Done", vim.log.levels.INFO)
    end,
    group = packer_group,
})

augroup('SiliconRefresh', { clear = true })
autocmd({ 'ColorScheme' },
    {
        group = 'SiliconRefresh',
        callback = function()
            require("silicon.utils").build_tmTheme()
            require("silicon.utils").reload_silicon_cache({ async = true })
        end,
        desc = 'Reload silicon themes cache on colorscheme switch',
    }
)
