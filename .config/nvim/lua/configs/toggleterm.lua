local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = "<M-t>",
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    highlights = {
        FloatBorder = { link = "FloatBorder" },
    },
    float_opts = {
        border = "curved",
        winblend = 0,
    },
})

function _G.set_terminal_keymaps()
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("keep", opts,
            { silent = true })
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    local opts = { buffer = 0 }
    map('t', '<esc>', [[<C-\><C-n>]], opts)
    map('t', 'jk', [[<C-\><C-n>]], opts)
    map('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    map('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    map('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    map('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = { "term://*" },
    callback = function() set_terminal_keymaps() end,
}
)

local Terminal = require("toggleterm.terminal").Terminal
local vertical = Terminal:new({
    direction = "vertical",
    hidden = true,
})

function _G.toggle_vertical()
    vertical:toggle()
end

local horizontal = Terminal:new({
    direction = "horizontal",
    hidden = true,
})

function _G.toggle_horizontal()
    horizontal:toggle()
end

local float = Terminal:new({
    direction = "float",
    hidden = true,
})

function _G.toggle_float()
    float:toggle()
end
