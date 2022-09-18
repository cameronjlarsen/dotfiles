local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

-- local map = vim.keymap.set
--
-- map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { silent = true, desc = "Node" })
-- map("n", "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", { silent = true, desc = "NCDU" })
-- map("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", { silent = true, desc = "Htop" })
-- map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { silent = true, desc = "Python" })
-- map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { silent = true, desc = "Float" })
-- map("n", "<leader>th", "<cmd>ToggleTerm size = 10 direction=horizontal<cr>", { silent = true,
--     desc = "Horizontal" })
-- map("n", "<leader>tv", "<cmd>ToggleTerm size = 80 direction=vertical<cr>", { silent = true, desc = "Vertical" })

toggleterm.setup({
    size = 20,
    open_mapping = [[<leader>t]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    -- shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
    ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
    python:toggle()
end
