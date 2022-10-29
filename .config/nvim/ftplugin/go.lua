vim.keymap.set("n", "<leader>dt", function() require("dap-go").debug_test() end, { silent = true, desc = "Debug Go Test" })
