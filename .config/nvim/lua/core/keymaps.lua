local map = require("core.utils").map

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
map("n", "<leader>wq", "<C-w>q", { desc = "Quit window" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-w>c", { desc = "Split window below" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window right" })
map("n", "<leader>wh", "<C-w>h", { desc = "Focus window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Focus window below" })
map("n", "<leader>wk", "<C-w>k", { desc = "Focus window above" })
map("n", "<leader>wl", "<C-w>l", { desc = "Focus window right" })
map("n", "<C-Left>", "<C-w>h", { desc = "Focus window left" })
map("n", "<C-Down>", "<C-w>j", { desc = "Focus window below" })
map("n", "<C-Up>", "<C-w>k", { desc = "Focus window above" })
map("n", "<C-Right>", "<C-w>l", { desc = "Focus window right" })
map("n", "<leader>wH", function() vim.cmd("vertical resize -2") end, { desc = "Resize left" })
map("n", "<leader>wJ", function() vim.cmd("resize +2") end, { desc = "Resize down" })
map("n", "<leader>wK", function() vim.cmd("resize -2") end, { desc = "Resize up" })
map("n", "<leader>wL", function() vim.cmd("vertical resize +2") end, { desc = "Resize right" })
map("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })

-- Navigate buffers
map("n", "<S-Right>", function() vim.cmd("bnext") end, { desc = "Go to next buffer" })
map("n", "<S-Left>", function() vim.cmd("bprevious") end, { desc = "Go to previous buffer" })

-- Keep text centered while searching
-- n = next result
-- zz = redraw at cursor (center screen)
-- zv = open enough folds to display the cursor position
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Insert --
-- Press jk fast to enter
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("v", "<A-up>", ":m .+1<CR>==", { desc = "Move text up" })
map("v", "<A-down>", ":m .-2<CR>==", { desc = "Move text down" })
map("v", "p", '"_dP', { desc = "Paste and keep in register" })

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move text up" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move text down" })
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move text up" })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move text down" })

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Focus terminal left" })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Focus terminal down" })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Focus terminal up" })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Focus terminal right" })

-- LSP --
map({ "n", "v" }, "<Leader>lv", function() require("core.utils").toggle_virtual_text() end, { desc = "Virtual Text" })
map({ "n", "v" }, "<Leader>lt", function() require("core.utils").toggle_diagnostics() end, { desc = "Toggle Diagnostics" })

-- Package Manager --
map("n", "<Leader>pp", function() vim.cmd("Lazy") end, { desc = "Open Lazy" })
map("n", "<Leader>pu", function() vim.cmd("Lazy update") end, { desc = "Update Plugins" })
