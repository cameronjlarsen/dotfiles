local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

copilot.setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            accept = "<CR>",
            jump_prev = "[[",
            jump_next = "]]",
            refresh = "gr",
            open = "<M-CR>"
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 50,
        keymap = {
            accept = false,
            accept_word = "<M-Right>",
            accept_line = "<M-Down>",
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
map("n", "<leader>lcp", function() require("copilot.panel").open({ position = "bottom", ratio = 0.3 }) end,
    { desc = "Open Copilot Panel" })
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
