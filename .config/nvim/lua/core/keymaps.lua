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

-- Navigate mux panes
map("n", "<A-h>", function() require("Navigator").left() end, { desc = "Navigate mux Pane Left" })
map("n", "<A-j>", function() require("Navigator").down() end, { desc = "Navigate mux Pane Down" })
map("n", "<A-k>", function() require("Navigator").up() end, { desc = "Navigate mux Pane Up" })
map("n", "<A-l>", function() require("Navigator").right() end, { desc = "Navigate mux Pane Right" })

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

-- Toggle terminal
map("n", "<leader>tt", function() toggle_float() end, { desc = "Toggle Float Terminal" })
map("n", "<leader>tv", function() toggle_vertical() end, { desc = "Toggle Vertical Terminal" })
map("n", "<leader>th", function() toggle_horizontal() end, { desc = "Toggle Horizontal Terminal" })

-- Files --
map("n", "<leader>f?", function() require("telescope.builtin").search_history() end, { desc = "Search History" })
map("n", "<leader>f:", function() require("telescope.builtin").command_history() end, { desc = "Command History" })
map("n", "<leader>fa", function() require("telescope.builtin").autocommands() end, { desc = "Auto Commands" })
map("n", "<leader>fb", function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    { desc = "Current Buffer" })
map("n", "<leader>fB", function() require("telescope").extensions.file_browser.file_browser() end,
    { desc = "File Browser" })
map("n", "<leader>fc", function() require("telescope.builtin").commands() end, { desc = "Commands" })
map("n", "<leader>fe", function() require("nvim-tree.api").tree.toggle({ find_file = false }) end, { desc = "Filetree" })
map("n", "<leader>fE", function() require("nvim-tree.api").tree.toggle({ find_file = true }) end,
    { desc = "Filetree Focus File" })
map("n", "<leader>ff", function() require("configs.telescope").find_files() end, { desc = "Files" })
map("n", "<leader>fgb", function() require("telescope.builtin").git_branches() end, { desc = "Branchs" })
map("n", "<leader>fgc", function() require("telescope.builtin").git_commits() end, { desc = "Commits" })
map("n", "<leader>fgs", function() require("telescope.builtin").git_status() end, { desc = "Changed Files" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help Pages" })
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Keymaps" })
map("n", "<leader>fl", function() require("telescope.builtin").resume() end, { desc = "Last Search" })
map("n", "<leader>fn", function() require("telescope").extensions.notify.notify() end, { desc = "Notifications" })
map("n", "<leader>fm", function() require("telescope").extensions.media_files.media_files() end, { desc = "Media Files" })
map("n", "<leader>fM", function() require("telescope.builtin").man_pages() end, { desc = "Man Pages" })
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Old Files" })
map("n", "<leader>fp", function() require("telescope").extensions.projects.projects() end, { desc = "Projects" })
map("n", "<leader>fr", function() require("telescope.builtin").registers() end, { desc = "Registers" })
map("n", "<leader>ft", function() require("telescope").extensions.live_grep_args.live_grep_args() end,
    { desc = "Live Grep" })
map("n", "<leader>fT", function() vim.cmd("Telescope builtin") end, { desc = "Telescope" })
map("n", "<leader>fs", function() require("telescope.builtin").symbols() end, { desc = "Symbols" })
map("n", "<leader>fv", function() require("telescope.builtin").vim_options() end, { desc = "Vim Options" })
map("n", "<leader>fw", function() require("telescope.builtin").grep_string() end, { desc = "Word Under Cursor" })


-- Git --
map("n", "<leader>gg", function() require("lazygit").lazygitcurrentfile() end, { desc = "LazyGit" })
map("n", "<leader>gr", function() require("telescope").extensions.lazygit.lazygit() end, { desc = "LazyGit Repos" })

-- Marks
map("n", "<leader>ma", function() require("harpoon.mark").add_file() end, { desc = "Add file to Harpoon" })
map("n", "<leader>mm", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon Quick Menu" })
map("n", "<leader>m.", function() require("harpoon.ui").nav_next() end, { desc = "Harpoon Next" })
map("n", "<leader>m,", function() require("harpoon.ui").nav_prev() end, { desc = "Harpoon Prev" })
map("n", "<leader>ms", function() require("telescope").extensions.harpoon.marks() end,
    { desc = "Harpoon Telescope Marks" })

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

-- Undo Tree --
map({ "n", "v" }, "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })

local wk_status_ok, which_key = pcall(require, "which-key")
if not wk_status_ok then
    return
end

which_key.register({
    ["<leader>"] = {
        b = { name = "+Buffer" },
        f = {
            name = "+Find",
            g = { name = "+Git" },
        },
        g = { name = "+Git" },
        l = { name = "+LSP" },
        m = { name = "+Marks" },
        p = { name = "+Packer" },
        S = { name = "+Silicon" },
        t = { name = "+Toggle" },
        u = { name = "+Undo Tree" },
        w = { name = "+Window" },
    },
}, { mode = "n" })
which_key.register({
    ["<leader>"] = {
        l = { name = "+LSP" },
        S = { name = "+Silicon" },
        u = { name = "+Undo Tree" },
    },
}, { mode = "v" })
