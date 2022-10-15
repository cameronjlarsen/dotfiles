vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    ]]
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

-- vim.api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "set awa" })
