local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
    return
end

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>",
    { desc = "Continue" })
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>",
    { desc = "UI" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
    { desc = "Toggle breakpoint" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>",
    { desc = "Step over" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>",
    { desc = "Step into" })
map("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>",
    { desc = "Step out" })
map("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = "Set breakpoint with condition" })
map("n", "<leader>dp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
    , { desc = "Set breakpoint with log point message" })
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>",
    { desc = "Toggle repl" })

-- Configure language adapters
require("config.dap.cpp")
require("config.dap.cs")
