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
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer" })

-----------------------------------------------------------
-- Plugin Mappings
-----------------------------------------------------------

-- Alpha --
map("n", "<leader>a", "<cmd>Alpha<cr>", { desc = "Alpha" })

-- Comment --
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    { desc = "Comment" })
map("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Comment" })

-- DAP --
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>",
    { desc = "Continue" })
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>",
    { desc = "UI" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
    { desc = "Toggle breakpoint" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>",
    { desc = "Step over" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>",
    { desc = "Step into" })
map("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>",
    { desc = "Step out" })
map("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = "Set breakpoint with condition" })
map("n", "<leader>dp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
    , { desc = "Set breakpoint with log point message" })
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>",
    { desc = "Toggle repl" })

-- Find Keymaps --
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",
    { desc = "Buffers" })
map("n", "<leader>fB", "<cmd>Telescope git_branches<cr>",
    { desc = "Checkout branch" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>",
    { desc = "Colorscheme" })
map("n", "<leader>ff",
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    { desc = "Find files" })
map("n", "<leader>ft", "<cmd>Telescope live_grep theme=ivy<cr>",
    { desc = "Find Text" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",
    { desc = "Help" })
map("n", "<leader>fi", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
    { desc = "Media" })
map("n", "<leader>fl", "<cmd>Telescope resume<cr>",
    { desc = "Last Search" })
map("n", "<leader>fM", "<cmd>Telescope man_pages<cr>",
    { desc = "Man Pages" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",
    { desc = "Recent File" })
map("n", "<leader>fR", "<cmd>Telescope registers<cr>",
    { desc = "Registers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>",
    { desc = "Keymaps" })
map("n", "<leader>fC", "<cmd>Telescope commands<cr>",
    { desc = "Commands" })
map("n", "<leader>fs", "<cmd>Telescope symbols<cr>",
    { desc = "Symbols" })
map("n", "<leader>fg", "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>",
    { desc = "LazyGit Repos" })

-- Git --
map("n", "<leader>go", "<cmd>Telescope git_status<cr>",
    { desc = "Open changed file" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>",
    { desc = "Checkout branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>",
    { desc = "Checkout commit" })
map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
    { desc = "Next Hunk" })
map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
    { desc = "Prev Hunk" })
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
    { desc = "Preview Hunk" })
map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
    { desc = "Reset Hunk" })
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
    { desc = "Reset Buffer" })
map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
    { desc = "Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    { desc = "Undo Stage Hunk" })
map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",
    { desc = "Blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",
    { desc = "Diff" })
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Knap --
-- Processes the document once, and refreshes the view
map({ "n", "v" }, "<leader>kp", function()
    require("knap").process_once()
end,
    { desc = "Preview Once" })
-- Closes the viewer application, and allows settings to be reset
map({ "n", "v" }, "<leader>kc", function()
    require("knap").close_viewer()
end,
    { desc = "Close Viewer" })
-- Toggles the auto-processing on and off
map({ "n", "v" }, "<leader>kt", function()
    require("knap").toggle_autopreviewing()
end,
    { desc = "Toggle Auto-Preview" })
-- Invokes a SyncTeX forward search, or similar, where appropriate
map({ "n", "v" }, "<leader>kj", function()
    require("knap").forward_jump()
end,
    { desc = "SyncTex jump" })

-- LSP Lines --
map({ "n", "v" }, "<Leader>ll", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- LSP Mappings --
map("n", "<leader>li", "<cmd>LspInfo<cr>", { silent = true, desc = "Info" })
map("n", "<leader>lI", "<cmd>Mason<cr>", { silent = true, desc = "Installer Info" })
map("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",
    { desc = "Document Diagnostics" })
map("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>",
    { desc = "Workspace Diagnostics" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",
    { desc = "Document Symbols" })
map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    { desc = "Workspace Symbols" })

-- Markdown Preview --
map("n", "<leader>mm", "<cmd>MarkdownPreview<cr>", { desc = "Start Markdown Preview" })
map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown Preview" })
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown Preview" })
map("n", "<leader>mg", "<cmd>Glow<cr>", { desc = "Glow Preview" })


-- Packer --
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Update" })

-- Toggle Terminal --
map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node" })
map("n", "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "NCDU" })
map("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Htop" })
map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
map("n", "<leader>th", "<cmd>ToggleTerm size = 10 direction=horizontal<cr>",
    { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size = 80 direction=vertical<cr>", { desc = "Vertical" })
