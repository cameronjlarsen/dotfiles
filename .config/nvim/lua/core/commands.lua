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
autocmd("BufWritePost", {
    command = "source <afile> | PackerSync",
    pattern = "packer.lua",
    group = packer_group,
})

autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
        vim.notify_once("Compile Done", vim.log.levels.INFO)
    end,
    group = packer_group,
})

autocmd("FileType", {
    pattern = "harpoon",
    callback = function()
        vim.notify_once("Harpoon autocmd", vim.log.levels.INFO)
        vim.opt_local.cursorline = true
    end,
})

autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
