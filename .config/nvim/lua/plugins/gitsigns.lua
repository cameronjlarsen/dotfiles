return {
    {
        "lewis6991/gitsigns.nvim",
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "󰐊" },
                topdelete = { text = "󰐊" },
                changedelete = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "󰐊" },
                topdelete = { text = "󰐊" },
                changedelete = { text = "▎" },
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
                map("n", "<leader>ghs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
                map("n", "<leader>ghr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
                map("v", "<leader>ghs", function() require("gitsigns").stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Stage Hunk" })
                map("v", "<leader>ghr", function() require("gitsigns").reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Reset Hunk" })
                map("n", "<leader>ghp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
                map("n", "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Stage Hunk" })
                map("n", "<leader>ghS", function() require("gitsigns").stage_buffer() end, { desc = "Stage Buffer" })
                map("n", "<leader>ghR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
                map("n", "<leader>ghb", function() require("gitsigns").blame_line() end, { desc = "Blame Line" })
                map("n", "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle Line Blame " })
                map("n", "<leader>gtd", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle Deleted " })
                map("n", "<leader>ghd", function() require("gitsigns").diffthis("@") end, { desc = "Git Diff Head" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        }
    }
}
