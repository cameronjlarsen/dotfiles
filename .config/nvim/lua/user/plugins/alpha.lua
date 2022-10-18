local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local home = os.getenv("HOME")
local dashboard = require("alpha.themes.dashboard")

local function info()
    local datetime = os.date("  %m-%d-%Y    %I:%M %p")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. nvim_version_info
end

local logo = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

local heading = {
    type = "text",
    val = info(),
    opts = {
        position = "center",
        hl = "String",
    },
}

local buttons = {
    dashboard.button("f", "  Find file", "<cmd>Telescope find_files <CR>", {}),
    dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>", {}),
    dashboard.button("p", "  Find project", "<cmd>Telescope projects <CR>", {}),
    dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles <CR>", {}),
    dashboard.button("t", "  Find text", "<cmd>Telescope live_grep <CR>", {}),
    dashboard.button("c", "  Configuration", "<cmd>e" .. home .. "/.config/nvim/init.lua | :cd %:p:h<CR>", {}),
    dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>", {}),
}

local function footer()
    -- Get number of plugins loaded by packer
    local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1))
    return "Neovim loaded " .. plugins_count .. " plugins "
end

dashboard.section.header.val = logo
dashboard.section.buttons.val = buttons
dashboard.section.footer.val = footer()
dashboard.section.header.opts.hl = "Type"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Type"

local opts = {
    layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 3 },
        heading,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
    },
    opts = {
        margin = 5
    },
}
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0
        vim.opt.cmdheight = 0
        vim.api.nvim_create_autocmd({ "BufUnload" }, {
            callback = function()
                vim.opt.showtabline = 2
                vim.opt.laststatus = 3
                vim.opt.cmdheight = 1
            end,
        })
    end,
})

alpha.setup(opts)
