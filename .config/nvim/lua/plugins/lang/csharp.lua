return {
    "mfussenegger/nvim-dap",
    opts = {
        netcoredbg = function()
            local dap = require("dap")

            local function get_debugger()
                local mason_registry = require("mason.registry")
                local debugger = mason_registry.get_package("netcoredbg")
                return debugger:get_install_path() .. "/netcoredbg"
            end
            dap.adapters.coreclr = {
                type = "executable",
                command = get_debugger(),
                args = { "--interpreter=vscode" },
            }
            dap.adapters.netcoredbg = {
                type = "executable",
                command = get_debugger(),
                args = { "--interpreter=vscode" },
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                    end,
                },
            }
        end,

    }
}
