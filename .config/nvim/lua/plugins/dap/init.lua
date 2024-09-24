return {
    {
        "mfussenegger/nvim-dap",
        cond = not vim.g.vscode,
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {
                    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                    mappings = {
                        -- Use a table to apply multiple mappings
                        expand = { "<CR>", "<2-LeftMouse>" },
                        open = "o",
                        remove = "d",
                        edit = "e",
                        repl = "r",
                        toggle = "t",
                    },
                    -- Expand lines larger than the window
                    -- Requires >= 0.7
                    expand_lines = vim.fn.has("nvim-0.7") == 1,
                    layouts = {
                        {
                            elements = {
                                -- Elements can be strings or table with id and size keys.
                                { id = "scopes",      size = 0.33 },
                                { id = "breakpoints", size = 0.17 },
                                { id = "stacks",      size = 0.25 },
                                { id = "watches",     size = 0.25 },
                            },
                            size = 0.33, -- 40 columns
                            position = "right",
                        },
                        {
                            elements = {
                                { id = "repl",    size = 0.45 },
                                { id = "console", size = 0.55 },
                            },
                            size = 0.25, -- 25% of total lines
                            position = "bottom",
                        },
                    },
                    controls = {
                        -- Requires Neovim nightly (or 0.8 when released)
                        enabled = true,
                        -- Display controls in this element
                        element = "repl",
                        icons = {
                            disconnect = "",
                            pause = "",
                            play = "",
                            step_into = "",
                            step_over = "",
                            step_out = "",
                            step_back = "",
                            run_last = "",
                            terminate = "",
                        },
                    },
                    floating = {
                        max_height = 0.9,   -- These can be integers or a float between 0 and 1.
                        max_width = 0.5,    -- Floats will be treated as percentage of your screen.
                        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
                        mappings = {
                            close = { "q", "<Esc>" },
                        },
                    },
                    windows = { indent = 1 },
                    render = {
                        indent = 1,
                        max_type_length = nil, -- Can be integer or nil.
                        max_value_lines = 100, -- Can be integer or nil.
                    }
                },
                config = function(_, opts)
                    local dap = require("dap")
                    local dapui = require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open()
                    end
                end,
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
        },
        keys = {
            {
                "<F5>",
                function() require("dap").continue() end,
                desc =
                "Continue"
            },
            {
                "<F9>",
                function() require("dap").step_back() end,
                desc =
                "Step Back"
            },
            {
                "<F10>",
                function() require("dap").step_over() end,
                desc =
                "Step Over"
            },
            {
                "<F11>",
                function() require("dap").step_into() end,
                desc =
                "Step Into"
            },
            {
                "<F12>",
                function() require("dap").step_out() end,
                desc =
                "Step Out"
            },
            { "<leader>d", "", desc = "+Dap" },
            {
                "<leader>db",
                function() require("dap").toggle_breakpoint() end,
                desc =
                "Toggle Breakpoint"
            },
            {
                "<leader>dc",
                function() require("dap").clear_breakpoints() end,
                desc =
                "Clear Breakpoints"
            },
            {
                "<leader>dl",
                function() require("dap").list_breakpoints() end,
                desc =
                "List Breakpoints"
            },
            {
                "<leader>dL",
                function() require("dap").run_last() end,
                desc =
                "Run Last"
            },
            {
                "<leader>dC",
                function() require("dap").run_to_cursor() end,
                desc =
                "Run To Cursor"
            },
            {
                "<leader>dd",
                function() require("dap").disconnect() end,
                desc =
                "Disconnect"
            },
            {
                "<leader>dg",
                function() require("dap").session() end,
                desc =
                "Get Session"
            },
            {
                "<leader>dr",
                function() require("dap").repl.toggle() end,
                desc =
                "Toggle Repl"
            },
            {
                "<leader>dp",
                function() require("dap").pause() end,
                desc =
                "Pause"
            },
            {
                "<leader>dq",
                function() require("dap").quit() end,
                desc =
                "Quit"
            },
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end,
                desc =
                "Set Breakpoint with Condition"
            },
            {
                "<leader>dp",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log Point Message: ")) end,
                desc =
                "Set Breakpoint with Log Point Message"
            },
            {
                "<leader>du",
                function() require("dapui").toggle({ reset = true }) end,
                desc =
                "UI"
            },
            ---@diagnostic disable-next-line: missing-parameter
            {
                "<leader>df",
                function() require("dapui").float_element() end,
                desc =
                "Floating Element"
            },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval Expression"
            },
        },
        opts = {
            defaults = {
                fallback = {
                    exception_breakpoints = { "raised" },
                },
            },
        },
        config = function(plugin, opts)
            local icons = { dap = require("core.icons").get("dap") }
            vim.fn.sign_define("DapBreakpoint",
                { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = icons.dap.BreakpointCondition, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = icons.dap.BreakpointRejected, texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint",
                { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

            for k, _ in pairs(opts.setup) do
                opts.setup[k](plugin, opts)
            end
        end,
    }
}
