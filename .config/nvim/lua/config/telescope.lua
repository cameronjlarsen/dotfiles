local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.load_extension('media_files')

local actions = require "telescope.actions"


local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- LSP mappings
map("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",
    { desc = "Document Diagnostics" })
map("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>",
    { desc = "Workspace Diagnostics" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",
    { desc = "Document Symbols" })
map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    { desc = "Workspace Symbols" })

-- Find keymaps
map("n", "<leader>fb", "<cmd>Telescope git_branches<cr>",
    { desc = "Checkout branch" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>",
    { desc = "Colorscheme" })
map("n", "<leader>ff",
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
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

-- Git keymaps
map("n", "<leader>go", "<cmd>Telescope git_status<cr>",
    { desc = "Open changed file" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>",
    { desc = "Checkout branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>",
    { desc = "Checkout commit" })

telescope.setup {
    defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
        },
        live_grep = {
            theme = "dropdown",
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
        },
        lsp_references = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_definitions = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_declarations = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_implementations = {
            theme = "dropdown",
            initial_mode = "normal",
        }
    },
    extensions = {
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
}
