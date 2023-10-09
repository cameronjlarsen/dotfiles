return {
    {
        "folke/which-key.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>f"] = { name = "+Find", g = "+Git" },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                cond = not vim.g.vscode,
                enabled = vim.fn.executable("make"),
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end
            },
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                cond = not vim.g.vscode,
                config = function()
                    require("telescope").load_extension("live_grep_args")
                end
            },
        },
        keys = {
            {
                "<leader>bb",
                function() require("telescope.builtin").buffers() end,
                desc =
                "Buffers"
            },
            {
                "<leader>f?",
                function() require("telescope.builtin").search_history() end,
                desc =
                "Search History"
            },
            {
                "<leader>f:",
                function() require("telescope.builtin").command_history() end,
                desc =
                "Command History"
            },
            {
                "<leader>fa",
                function() require("telescope.builtin").autocommands() end,
                desc =
                "Auto Commands"
            },
            {
                "<leader>fb",
                function() require("telescope.builtin").current_buffer_fuzzy_find() end,
                desc =
                "Current Buffer"
            },
            {
                "<leader>fB",
                function() require("telescope").extensions.file_browser.file_browser() end,
                desc =
                "File Browser"
            },
            {
                "<leader>fc",
                function() require("telescope.builtin").commands() end,
                desc =
                "Commands"
            },
            {
                "<leader>ff",
                function() require("core.utils").find_files() end,
                desc =
                "Files"
            },
            {
                "<leader>fgb",
                function() require("telescope.builtin").git_branches() end,
                desc =
                "Branchs"
            },
            {
                "<leader>fgc",
                function() require("telescope.builtin").git_commits() end,
                desc =
                "Commits"
            },
            {
                "<leader>fgs",
                function() require("telescope.builtin").git_status() end,
                desc =
                "Changed Files"
            },
            {
                "<leader>fh",
                function() require("telescope.builtin").help_tags() end,
                desc =
                "Help Pages"
            },
            {
                "<leader>fk",
                function() require("telescope.builtin").keymaps() end,
                desc =
                "Keymaps"
            },
            {
                "<leader>fl",
                function() require("telescope.builtin").resume() end,
                desc =
                "Last Search"
            },
            {
                "<leader>fn",
                function() require("telescope").extensions.notify.notify() end,
                desc =
                "Notifications"
            },
            {
                "<leader>fm",
                function() require("telescope").extensions.media_files.media_files() end,
                desc =
                "Media Files"
            },
            {
                "<leader>fM",
                function() require("telescope.builtin").man_pages() end,
                desc =
                "Man Pages"
            },
            {
                "<leader>fo",
                function() require("telescope.builtin").oldfiles() end,
                desc =
                "Old Files"
            },
            {
                "<leader>fp",
                function() require("telescope").extensions.projects.projects() end,
                desc =
                "Projects"
            },
            {
                "<leader>fr",
                function() require("telescope.builtin").registers() end,
                desc =
                "Registers"
            },
            {
                "<leader>ft",
                function() require("telescope").extensions.live_grep_args.live_grep_args() end,
                desc =
                "Live Grep"
            },
            {
                "<leader>fT",
                function() vim.cmd("Telescope builtin") end,
                desc =
                "Telescope"
            },
            {
                "<leader>fs",
                function() require("telescope.builtin").symbols() end,
                desc =
                "Symbols"
            },
            {
                "<leader>fv",
                function() require("telescope.builtin").vim_options() end,
                desc =
                "Vim Options"
            },
            {
                "<leader>fw",
                function() require("telescope.builtin").grep_string() end,
                desc =
                "Word Under Cursor"
            },
        },
        opts = function()
            local actions = require "telescope.actions"
            local actions_layout = require "telescope.actions.layout"
            return {
                defaults = {
                    error_mode = "notify",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--hidden",
                        "--smart-case",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    path_display = { "smart" },
                    sorting_strategy = "ascending",
                    layout_strategy = "flex",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.7,
                        },
                        vertical = {
                            prompt_position = "top",
                            mirror = false,
                        },
                        flex = {
                            prompt_position = "top",
                            preview_width = 0.7,
                            flip_columns = 120,
                        },
                        bottom_pane = {
                            height = 0.50,
                        },
                        width = 0.9,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
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
                    current_buffer_fuzzy_find = {
                        previewer = false,
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                    },
                    git_files = {
                        show_untracked = true,
                    },
                },
                extensions = {
                    media_files = {
                        find_cmd = "fd" -- find command (defaults to `fd`)
                    },
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    harpoon = {
                        theme = "dropdown",
                        preview = false,
                    },
                    file_browser = {
                        grouped = true,
                    },
                    live_grep_args = {
                        mappings = {
                            i = {
                                ["<C-o>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                                ["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix =
                                " --iglob " }),
                            }
                        }
                    }
                },
            }
        end,

    }
}
