local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

-- Configure language adapters
require("user.plugins.dap.cpp")
require("user.plugins.dap.cs")
require("user.plugins.dap.python")

require("user.plugins.dap.ui")

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
    return
end

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>dc", function() dap.continue() end, { desc = "Continue" })
map("n", "<leader>du", function() dapui.toggle() end, { desc = "UI" })
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "Step over" })
map("n", "<leader>di", function() dap.step_into() end, { desc = "Step into" })
map("n", "<leader>dO", function() dap.step_out() end, { desc = "Step out" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle repl" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "Set breakpoint with condition" })
map("n", "<leader>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "Set breakpoint with log point message" })

wk.register({
    d = {
        name = "+Debug",
    },
}, { prefix = "<leader>" })
