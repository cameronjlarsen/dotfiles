local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

copilot.setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<M-l>",
            next = "<M-j>",
            prev = "<M-k>",
            dismiss = "<M-h>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = 'node', -- Node version must be < 18
    plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
    server_opts_overrides = {
        trace = "verbose",
        settings = {
            advanced = {
                listCount = 10,
                inlineSuggestCount = 3,
            },
        }
    },
})

-- Setup cmp source
require("copilot_cmp").setup()

local map = require("core.utils").map
map("i", "<M-Right>", function() require("copilot.suggestion").accept() end, { desc = "Accept Copilot Suggestion" })
map("i", "<M-Left>", function() require("copilot.suggestion").dismiss() end, { desc = "Dismiss Copilot Suggestion" })
map("i", "<M-Up>", function() require("copilot.suggestion").prev() end, { desc = "Previous Copilot Suggestion" })
map("i", "<M-Down>", function() require("copilot.suggestion").next() end, { desc = "Next Copilot Suggestion" })
map("n", "<leader>lcp", function() require("copilot.panel").open() end, { desc = "Open Copilot Panel" })
map("n", "<leader>lcs", function() require("copilot.suggestion").toggle_auto_trigger() end,
    { desc = "Toggle Copilot Auto Trigger" })

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
    return
end

wk.register({
    ["<leader>"] = {
        l = { name = "+LSP",
            c = { name = "+Copilot",
            },
        },
    },
}, { mode = "n" })
