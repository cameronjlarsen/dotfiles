local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"
local actions_layout = require "telescope.actions.layout"

telescope.setup {
    defaults = {
        -- theme = "dropdown",
        -- layout_strategy = "vertical",
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<ESC>"] = actions.close,

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
                ["<M-p>"] = actions_layout.toggle_preview,
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
                ["<M-p>"] = actions_layout.toggle_preview,
            },
        },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
        },
        live_grep = {
            theme = "ivy",
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
        },
        lsp_references = {
            theme = "dropdown",
        },
        lsp_definitions = {
            theme = "dropdown",
        },
        lsp_declarations = {
            theme = "dropdown",
        },
        lsp_implementations = {
            theme = "dropdown",
        },
        git_branches = {
            theme = "dropdown",
        },
        git_files = {
            theme = "dropdown",
        },
    },
    extensions = {
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            -- filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "fdfind" -- find command (defaults to `fd`)
        },
    },
}

-- Extenstions
telescope.load_extension("media_files")
telescope.load_extension("lazygit")
telescope.load_extension("notify")
