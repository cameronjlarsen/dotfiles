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
map("n", "<leader>wv", "<C-w>c", { desc = "Split window right" })
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
map("n", "<leader>bn", function() vim.cmd("BufferLineCycleNext") end, { desc = "Next Buffer" })
map("n", "<leader>bp", function() vim.cmd("BufferLineCyclePrev") end, { desc = "Prev Buffer" })
map("n", "<leader>bc", function() vim.cmd("Bdelete!") end, { desc = "Close Buffer" })
map("n", "<leader>bd", function() vim.cmd("Bdelete") end, { desc = "Delete Buffer & Window" })
map("n", "<leader>bb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })


-- Keep text centered while searching
-- n = next result
-- zz = redraw at cursor (center screen)
-- zv = open enough folds to display the cursor position
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })
map("n", "<leader>th", function() vim.cmd("nohlsearch") end, { desc = "No Highlight Search" })

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

-- Files --
map("n", "<leader>fe", function() require("nvim-tree").toggle() end, { desc = "Filetree" })
map("n", "<leader>ff", function() require("core.utils").telescope_find_files() end, { desc = "Find Files" })
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Find Recent Files" })
map("n", "<leader>fb", function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    { desc = "Current Buffer" })
map("n", "<leader>fp", function() require("telescope").extensions.projects.projects() end, { desc = "Projects" })
map("n", "<leader>fb", function() require("telescope").extensions.file_browser.file_browser() end,
    { desc = "File Browser" })
map("n", "<leader>fm", function() require("telescope").extensions.media_files.media_files() end,
    { desc = "Find Media Files" })

-- Search --
map("n", "<leader>s?", function() require("telescope.builtin").search_history() end, { desc = "Search History" })
map("n", "<leader>s:", function() require("telescope.builtin").command_history() end, { desc = "Command History" })
map("n", "<leader>st", function() require("telescope.builtin").live_grep() end, { desc = "Live Grep" })
map("n", "<leader>sw", function() require("telescope.builtin").grep_string() end, { desc = "Word Under Cursor" })
map("n", "<leader>so", function() require("telescope.builtin").vim_options() end, { desc = "Vim Options" })
map("n", "<leader>ss", function() require("telescope.builtin").symbols() end, { desc = "Symbols" })
map("n", "<leader>sa", function() require("telescope.builtin").autocommands() end, { desc = "Auto Commands" })
map("n", "<leader>sc", function() require("telescope.builtin").commands() end, { desc = "Commands" })
map("n", "<leader>sl", function() require("telescope.builtin").resume() end, { desc = "Last Search" })
map("n", "<leader>sk", function() require("telescope.builtin").keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sr", function() require("telescope.builtin").registers() end, { desc = "Registers" })

-- Help --
map("n", "<leader>hh", function() require("telescope.builtin").help_tags() end, { desc = "Help Pages" })
map("n", "<leader>hm", function() require("telescope.builtin").man_pages() end, { desc = "Man Pages" })
map("n", "<leader>hn", function() require("telescope").extensions.notify.notify() end, { desc = "Notifications" })
map("n", "<leader>ht", function() vim.cmd("Telescope builtin") end, { desc = "Telescope" })

-- Git --
map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Checkout Branch" })
map("n", "<leader>gc", function() require("telescope.builtin").git_commits() end, { desc = "Checkout Commit" })
map("n", "<leader>gs", function() require("telescope.builtin").git_status() end, { desc = "Open Changed File" })
map("n", "<leader>gg", function() require("lazygit").lazygitcurrentfile() end, { desc = "LazyGit" })
map("n", "<leader>gr", function() require("telescope").extensions.lazygit.lazygit() end, { desc = "LazyGit Repos" })

-- Knap --
map({ "n", "v" }, "<F6>", function() require("knap").close_viewer() end, { desc = "Close Viewer" })
map({ "n", "v" }, "<F7>", function() require("knap").toggle_autopreviewing() end, { desc = "Toggle Auto-Preview" })
map({ "n", "v" }, "<F8>", function() require("knap").forward_jump() end, { desc = "SyncTex jump" })

-- LSP --
map("n", "<leader>li", function() vim.cmd("LspInfo") end, { silent = true, desc = "LSP Info" })
map("n", "<leader>lm", function() vim.cmd("Mason") end, { silent = true, desc = "Mason Info" })
map("n", "<leader>ln", function() vim.cmd("NullLsInfo") end, { silent = true, desc = "Null-Ls Info" })
map({ "n", "v" }, "<Leader>lv", function() require("core.utils").toggle_virtual_text() end, { desc = "Virtual Text" })
map({ "n", "v" }, "<Leader>lt", function() require("core.utils").toggle_diagnostics() end,
    { desc = "Toggle Diagnostics" })

-- Packer --
map("n", "<leader>pc", function() require("packer").compile() end, { desc = "Packer Compile" })
map("n", "<leader>pi", function() require("packer").install() end, { desc = "Packer Install" })
map("n", "<leader>pp", function() require("packer").sync({ preview_updates = true }) end,
    { desc = "Packer Sync Preview" })
map("n", "<leader>pP", function() require("packer").sync() end, { desc = "Packer Sync" })
map("n", "<leader>ps", function() require("packer").status() end, { desc = "Packer Status" })
map("n", "<leader>pu", function() require("packer").update({ preview_updates = true }) end,
    { desc = "Packer Update Preview" })
map("n", "<leader>pU", function() require("packer").update() end, { desc = "Packer Update" })

-- Silicon --
map({ "n", "v" }, "<leader>Sl", function() require("silicon").visualise_api({ debug = true }) end,
    { desc = "Screenshot Line(s)" })
map({ "n", "v" }, "<leader>Sb", function() require("silicon").visualise_api({ debug = true, show_buf = true }) end,
    { desc = "Screenshot Line(s) with Buffer" })
map({ "n", "v" }, "<leader>Sy", function() require("silicon").visualise_api({ debug = true, to_clip = true }) end,
    { desc = "Screenshot Line(s) to Clipboard" })

local wk_status_ok, which_key = pcall(require, "which-key")
if not wk_status_ok then
    return
end

which_key.register({
    ["<leader>"] = {
        b = { name = "+Buffer" },
        f = { name = "+Files" },
        g = { name = "+Git" },
        h = { name = "+Help" },
        l = { name = "+LSP" },
        p = { name = "+Packer" },
        s = { name = "+Search" },
        S = { name = "+Silicon" },
        t = { name = "+Toggle" },
        w = { name = "+Window" },
    },
}, { mode = "n" })
which_key.register({
    ["<leader>"] = {
        l = { name = "+LSP" },
        S = { name = "+Silicon" },
    },
}, { mode = "v" })
