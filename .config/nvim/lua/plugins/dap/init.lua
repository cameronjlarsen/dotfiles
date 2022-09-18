local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
    return
end

-- local map = vim.keymap.set
--
-- map({ "n", "v" }, "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { silent = true, desc = "Continue" })
-- map({ "n", "v" }, "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { silent = true, desc = "UI" })
-- map({ "n", "v" }, "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
--     { silent = true, desc = "Toggle breakpoint" })
-- map({ "n", "v" }, "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { silent = true, desc = "Step over" })
-- map({ "n", "v" }, "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { silent = true, desc = "Step into" })
-- map({ "n", "v" }, "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", { silent = true, desc = "Step out" })
-- map({ "n", "v" }, "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
--     { silent = true, desc = "Set breakpoint with condition" })
-- map({ "n", "v" }, "<leader>dp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
--     , { silent = true, desc = "Set breakpoint with log point message" })
-- map({ "n", "v" }, "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", { silent = true, desc = "Toggle repl" })

-- Configure language adapters
require("plugins.dap.cpp")
require("plugins.dap.cs")
