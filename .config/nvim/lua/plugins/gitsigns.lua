return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                mode = { "n", "v" },
                ["<leader>g"] = {
                    name = "+Git",
                    h = { name = "+Hunk" },
                    t = { name = "+Toggle" }
                }
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "󰐊", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "󰐊",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn"
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "▎",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn"
                },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter_opts = {
                relative_time = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    if type(opts) == "string" then
                        opts = { desc = opts }
                    end
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Next Hunk" })

                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Prev Hunk" })

                --Actions
                map({ "n", "v" }, "<leader>ghs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
                map({ "n", "v" }, "<leader>ghr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
                map("n", "<leader>ghp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
                map("n", "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end,
                    { desc = "Undo Stage Hunk" })
                map("n", "<leader>ghS", function() require("gitsigns").stage_buffer() end, { desc = "Stage Buffer" })
                map("n", "<leader>ghR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
                map("n", "<leader>ghb", function() require("gitsigns").blame_line() end, { desc = "Blame Line" })
                map("n", "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end,
                    { desc = "Toggle Line Blame " })
                map("n", "<leader>gtd", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle Deleted " })
                map("n", "<leader>ghd", function() require("gitsigns").diffthis("@") end, { desc = "Git Diff Head" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        }
    }
}
