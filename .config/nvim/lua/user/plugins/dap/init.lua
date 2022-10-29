local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local dap_vt_status_ok, dapvt = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_status_ok then
    return
end

-- Configure language adapters
require("user.plugins.dap.cpp")
require("user.plugins.dap.cs")
require("user.plugins.dap.python")
require("user.plugins.dap.go")
require("user.plugins.dap.ui")
dapvt.setup()

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
    return
end

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
map("n", "<leader>du", function() dapui.toggle() end, { desc = "UI" })
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
map("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
map("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
map("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle Repl" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end,
    { desc = "Set Breakpoint with Condition" })
map("n", "<leader>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log Point Message: ")) end,
    { desc = "Set Breakpoint with Log Point Message" })

wk.register({
    d = {
        name = "+Debug",
    },
}, { prefix = "<leader>" })
