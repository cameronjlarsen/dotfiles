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

---@diagnostic disable-next-line: assign-type-mismatch
dap.defaults.fallback.exception_breakpoints = { "raised" }

-- Configure language adapters
require("configs.dap.cpp")
require("configs.dap.cs")
require("configs.dap.python")
require("configs.dap.go")
require("configs.dap.bash")
require("configs.dap.ui")
dapvt.setup()

local map = require("core.utils").map

map("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
map("n", "<F9>", function() dap.step_back() end, { desc = "Step Back" })
map("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
map("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
map("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function() dap.clear_breakpoints() end, { desc = "Clear Breakpoints" })
map("n", "<leader>dl", function() dap.list_breakpoints() end, { desc = "List Breakpoints" })
map("n", "<leader>dL", function() dap.run_last() end, { desc = "Run Last" })
map("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run To Cursor" })
map("n", "<leader>dd", function() dap.disconnect() end, { desc = "Disconnect" })
map("n", "<leader>dg", function() dap.session() end, { desc = "Get Session" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle Repl" })
map("n", "<leader>dp", function() dap.pause() end, { desc = "Pause" })
map("n", "<leader>dq", function() dap.quit() end, { desc = "Quit" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end,
    { desc = "Set Breakpoint with Condition" })
map("n", "<leader>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log Point Message: ")) end,
    { desc = "Set Breakpoint with Log Point Message" })
map("n", "<leader>du", function() dapui.toggle({ reset = true }) end, { desc = "UI" })
map("n", "<leader>df", function() dapui.float_element() end, { desc = "Floating Element" })
map({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "Eval Expression" })

local wk_status_ok, which_key = pcall(require, "which-key")
if not wk_status_ok then
    return
end

which_key.register({
    ["<leader>"] = {
        d = { name = "+Debug", },
    }
}, { mode = "n" })
which_key.register({
    ["<leader>"] = {
        d = { name = "+Debug", },
    },
}, { mode = "v" })
