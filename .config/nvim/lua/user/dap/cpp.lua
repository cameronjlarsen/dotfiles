local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

-- Adapters
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/usr/bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

-- Configurations
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

		runInTerminal = false,

		-- 💀
		-- If you use `runInTerminal = true` and resize the terminal window,
		-- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
		-- To avoid that uncomment the following option
		-- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = "cpp", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

