local function get_codelldb()
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb"
    local codelldb_path = mason_path .. "/extension/adapter/codelldb"
    local liblldb_path = mason_path .. "/extension/lldb/lib/liblldb.so"
    
    if vim.fn.filereadable(codelldb_path) == 0 then
        vim.notify("codelldb not found at: " .. codelldb_path, vim.log.levels.ERROR)
        return nil, nil
    end
    
    return codelldb_path, liblldb_path
end

return {
    "mfussenegger/nvim-dap",
    cond = not vim.g.vscode,
    opts = {
        setup = {
            codelldb = function()
                local codelldb_path, _ = get_codelldb()
                if not codelldb_path then
                    return
                end
                local dap = require("dap")
                dap.adapters.lldb = {
                    type = "executable",
                    port = "${port}",
                    executable = {
                        command = codelldb_path,
                        args = { "--port", "${port}" },
                    }
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
                        type = "codelldb",
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = {},
                        runInTerminal = false,
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
            end,
        },
    },
}
