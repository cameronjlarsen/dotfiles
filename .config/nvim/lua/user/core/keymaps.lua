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
map("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize up" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize right" })

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>c", "<cmd>Bdelete!<CR>", { desc = "Close Buffer" })

-- Keep text centered while searching
-- n = next result
-- zz = redraw at cursor (center screen)
-- zv = open enough folds to display the cursor position
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight Search" })

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

-- File Explorer --
map("n", "<leader>e", function() require("nvim-tree").toggle() end, { desc = "Explorer" })

-----------------------------------------------------------
-- Plugin Mappings
-----------------------------------------------------------

-- Alpha --
map("n", "<leader>a", "<cmd>Alpha<cr>", { desc = "Alpha" })

-- Comment --
map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end,
    { desc = "Comment" })
map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Comment" })

-- DAP --
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "UI" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle repl" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "Set breakpoint with condition" })
map("n", "<leader>dp", function() require "dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "Set breakpoint with log point message" })

-- Diagnostics --
map("n", "gl", vim.diagnostic.open_float, { desc = "Show Line Diagnostic" })
map("n", "<leader>lj", function() vim.diagnostic.goto_next({ border = "rounded" }) end, { desc = "Next Diagnostic" })
map("n", "<leader>lk", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, { desc = "Prev Diagnostic" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Send Diagnostics to Quickfix" })
map("n", "<leader>ld", function() return require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
    { desc = "Document Diagnostics" })
map("n", "<leader>lw", function() return require("telescope.builtin").diagnostics() end,
    { desc = "Workspace Diagnostics" })
map("n", "<leader>ls", function() return require("telescope.builtin").lsp_document_symbols() end,
    { desc = "Document Symbols" })
map("n", "<leader>lS", function() return require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
    { desc = "Workspace Symbols" })

-- Find Keymaps --
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fB", function() require("telescope.builtin").git_branches() end, { desc = "Checkout Branch" })
map("n", "<leader>fc", function() require("telescope.builtin").colorscheme() end, { desc = "Colorscheme" })
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find Files" })
map("n", "<leader>ft", function() require("telescope.builtin").live_grep() end, { desc = "Find Text" })
map("n", "<leader>fT", function() require("telescope.builtin").grep_string() end, { desc = "Find Text Under Cursor" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help" })
map("n", "<leader>fi", function() require("telescope").extensions.media_files.media_files() end, { desc = "Media" })
map("n", "<leader>fl", function() require("telescope.builtin").resume() end, { desc = "Last Search" })
map("n", "<leader>fM", function() require("telescope.builtin").man_pages() end, { desc = "Man Pages" })
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Recent File" })
map("n", "<leader>fR", function() require("telescope.builtin").registers() end, { desc = "Registers" })
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Keymaps" })
map("n", "<leader>fC", function() require("telescope.builtin").commands() end, { desc = "Commands" })
map("n", "<leader>fs", function() require("telescope.builtin").symbols() end, { desc = "Symbols" })
map("n", "<leader>fg", function() require("telescope").extensions.lazygit.lazygit() end, { desc = "LazyGit Repos" })

-- Git --
map("n", "<leader>go", function() require("telescope.builtin").git_status() end, { desc = "Open Changed File" })
map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Checkout Branch" })
map("n", "<leader>gc", function() require("telescope.builtin").git_commits() end, { desc = "Checkout Commit" })
map("n", "<leader>gjh", function() require("gitsigns").next_hunk() end, { desc = "Next Hunk" })
map("n", "<leader>gkh", function() require("gitsigns").prev_hunk() end, { desc = "Prev Hunk" })
map("n", "<leader>gph", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
map("n", "<leader>grh", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
map("n", "<leader>grb", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
map("n", "<leader>gsh", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map("n", "<leader>guh", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Stage Hunk" })
map("n", "<leader>gsb", function() require("gitsigns").stage_buffer() end, { desc = "Stage Buffer" })
map("n", "<leader>gl", function() require("gitsigns").blame_line() end, { desc = "Blame Line" })
map("n", "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle Line Blame " })
map("n", "<leader>gtd", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle Deleted " })
map("n", "<leader>gd", function() require("gitsigns").diffthis("@") end, { desc = "Git Diff Head" })
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Knap --
map({ "n", "v" }, "<leader>kp", function() require("knap").process_once() end, { desc = "Preview Once" })
map({ "n", "v" }, "<leader>kc", function() require("knap").close_viewer() end, { desc = "Close Viewer" })
map({ "n", "v" }, "<leader>kt", function() require("knap").toggle_autopreviewing() end, { desc = "Toggle Auto-Preview" })
map({ "n", "v" }, "<leader>kj", function() require("knap").forward_jump() end, { desc = "SyncTex jump" })

-- LSP Lines --
map({ "n", "v" }, "<Leader>ll", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- LSP Mappings --
map("n", "<leader>li", "<cmd>LspInfo<cr>", { silent = true, desc = "LSP Info" })
map("n", "<leader>lI", "<cmd>Mason<cr>", { silent = true, desc = "Mason Installer Info" })

-- Markdown Preview --
map("n", "<leader>mm", "<cmd>MarkdownPreview<cr>", { desc = "Start Markdown Preview" })
map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown Preview" })
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown Preview" })
map("n", "<leader>mg", "<cmd>Glow<cr>", { desc = "Glow Preview" })

-- Packer --
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer Update" })

-- Toggle Terminal --
map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node Terminal" })
map("n", "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "NCDU Terminal" })
map("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Htop Terminal" })
map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python Terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm size = 10 direction=horizontal<cr>", { desc = "Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size = 80 direction=vertical<cr>", { desc = "Vertical Terminal" })
