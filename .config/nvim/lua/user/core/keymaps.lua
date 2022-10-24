local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

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
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-w>c", { desc = "Split window below" })
map("n", "<leader>wv", "<C-w>c", { desc = "Split window right" })
map("n", "<leader>wh", "<C-w>h", { desc = "Focus window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Focus window below" })
map("n", "<leader>wk", "<C-w>k", { desc = "Focus window above" })
map("n", "<leader>wl", "<C-w>l", { desc = "Focus window right" })
map("n", "<leader>wH", function() vim.cmd("vertical resize -2") end, { desc = "Resize left" })
map("n", "<leader>wJ", function() vim.cmd("resize +2") end, { desc = "Resize down" })
map("n", "<leader>wK", function() vim.cmd("resize -2") end, { desc = "Resize up" })
map("n", "<leader>wL", function() vim.cmd("vertical resize +2") end, { desc = "Resize right" })
map("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })


-- Navigate buffers
map("n", "<C-Right>", function() vim.cmd("bnext") end, { desc = "Go to next buffer" })
map("n", "<C-Left>", function() vim.cmd("bprevious") end, { desc = "Go to previous buffer" })
map("n", "<leader>bn", function() vim.cmd("BufferLineCycleNext") end, { desc = "Next Buffer" })
map("n", "<leader>bp", function() vim.cmd("BufferLineCyclePrev") end, { desc = "Prev Buffer" })
map("n", "<leader>bc", function() vim.cmd("Bdelete!") end, { desc = "Close Buffer" })
map("n", "<leader>bd", function() vim.cmd("Bdelete") end, { desc = "Delete Buffer & Window" })


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

-- Search --
map("n", "<leader>sb", function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    { desc = "Current Buffer" })
map("n", "<leader>sc", function() require("telescope.builtin").colorscheme() end, { desc = "Colorschemes" })
map("n", "<leader>sh", function() require("telescope.builtin").command_history() end, { desc = "Command History" })
map("n", "<leader>sl", function() require("telescope.builtin").resume() end, { desc = "Last Search" })
map("n", "<leader>st", function() require("telescope.builtin").live_grep() end, { desc = "Grep" })
map("n", "<leader>sw", function() require("telescope.builtin").grep_string() end, { desc = "Grep String" })
map("n", "<leader>sn", function() require('telescope').extensions.notify.notify() end, { desc = "Notifications" })
map("n", "<leader>sp", function() require('telescope').extensions.projects.projects() end, { desc = "Projects" })
map("n", "<leader>ss", function()
    require("telescope.builtin").lsp_document_symbols({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Variable" },
    })
end, { desc = "Document Symbols" })
map("n", "<leader>sS", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Variable" },
    })
end, { desc = "Workspace Symbols" })

-- Help --
map("n", "<leader>ha", function() require("telescope.builtin").autocommands() end, { desc = "Auto Commands" })
map("n", "<leader>hb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>hc", function() require("telescope.builtin").commands() end, { desc = "Commands" })
map("n", "<leader>hh", function() require("telescope.builtin").help_tags() end, { desc = "Help Pages" })
map("n", "<leader>hk", function() require("telescope.builtin").keymaps() end, { desc = "Keymaps" })
map("n", "<leader>hm", function() require("telescope.builtin").man_pages() end, { desc = "Man Pages" })
map("n", "<leader>ho", function() require("telescope.builtin").vim_options() end, { desc = "Vim Options" })
map("n", "<leader>hr", function() require("telescope.builtin").registers() end, { desc = "Registers" })
map("n", "<leader>hs", function() require("telescope.builtin").symbols() end, { desc = "Symbols" })
map("n", "<leader>ht", function() vim.cmd("Telescope builtin") end, { desc = "Telescope" })

map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find Files" })
map("n", "<leader>fg", function() require("telescope.builtin").git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fm", function() require("telescope").extensions.media_files.media_files() end,
    { desc = "Find Media Files" })
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Find Recent Files" })
map("n", "<leader>ft", function() require("nvim-tree").toggle() end, { desc = "Filetree" })


-- Git --
map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Checkout Branch" })
map("n", "<leader>gc", function() require("telescope.builtin").git_commits() end, { desc = "Checkout Commit" })
map("n", "<leader>gs", function() require("telescope.builtin").git_status() end, { desc = "Open Changed File" })
map("n", "<leader>gg", function() vim.cmd("LazyGit") end, { desc = "LazyGit" })
map("n", "<leader>gr", function() require("telescope").extensions.lazygit.lazygit() end, { desc = "LazyGit Repos" })

-- Knap --
map({ "n", "v" }, "<leader>kp", function() require("knap").process_once() end, { desc = "Preview Once" })
map({ "n", "v" }, "<leader>kc", function() require("knap").close_viewer() end, { desc = "Close Viewer" })
map({ "n", "v" }, "<leader>kt", function() require("knap").toggle_autopreviewing() end, { desc = "Toggle Auto-Preview" })
map({ "n", "v" }, "<leader>kj", function() require("knap").forward_jump() end, { desc = "SyncTex jump" })

-- LSP --
map("n", "<leader>li", function() vim.cmd("LspInfo") end, { silent = true, desc = "LSP Info" })
map("n", "<leader>lm", function() vim.cmd("Mason") end, { silent = true, desc = "Mason Installer Info" })
map({ "n", "v" }, "<Leader>ll",
    function()
        local new_value = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({
            virtual_text = not new_value,
            virtual_lines = new_value,
        })
    end,
    { desc = "Toggle lsp_lines" })

-- Packer --
map("n", "<leader>pc", function() vim.cmd("PackerCompile") end, { desc = "Packer Compile" })
map("n", "<leader>pi", function() vim.cmd("PackerInstall") end, { desc = "Packer Install" })
map("n", "<leader>pp", function() vim.cmd("PackerSync") end, { desc = "Packer Sync" })
map("n", "<leader>ps", function() vim.cmd("PackerStatus") end, { desc = "Packer Status" })
map("n", "<leader>pu", function() vim.cmd("PackerUpdate") end, { desc = "Packer Update" })
