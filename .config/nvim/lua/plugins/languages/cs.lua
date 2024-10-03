return {
    {
        "mfussenegger/nvim-dap",
        cond = not vim.g.vscode,
        opts = {
            setup = {
                netcoredbg = function()
                    local dap = require("dap")
                    local dap_utils = require("dap.utils")

                    if not dap.adapters.coreclr then
                        dap.adapters.coreclr = {
                            type = "executable",
                            command = vim.fn.exepath("netcoredbg"),
                            args = { "--interpreter=vscode" },
                            options = {
                                detached = false,
                            },

                        }
                    end

                    for _, lang in ipairs({ "cs", "fs", "vb" }) do
                        if not dap.configurations[lang] then
                            dap.configurations[lang] = {
                                {
                                    type = "coreclr",
                                    name = "launch - netcoredbg",
                                    request = "launch",
                                    program = function()
                                        local project_path = vim.fs.root(0, function(name)
                                            return name:match("%." .. lang .. "proj$") ~= nil
                                        end)

                                        if not project_path then
                                            return vim.notify("Couldn't find the csproj path")
                                        end

                                        return dap_utils.pick_file({
                                            filter = string.format("Debug/.*/%s",
                                                vim.fn.fnamemodify(project_path, ":t:r")),
                                            path = string.format("%s/bin", project_path),
                                        })
                                    end,
                                    cwd = "${workspaceFolder}",
                                },
                                {
                                    type = "coreclr",
                                    name = "attach - netcoredbg",
                                    request = "attach",
                                    processId = dap_utils.pick_process,
                                },
                                {
                                    type = "coreclr",
                                    name = "Attach (Smart)",
                                    request = "attach",
                                    processId = function()
                                        if not vim.g.roslyn_nvim_selected_solution then
                                            return vim.notify("No solution file found")
                                        end

                                        local solution_dir = vim.fs.dirname(vim.g.roslyn_nvim_selected_solution)

                                        local res = vim.system({ "dotnet", "sln", vim.g
                                            .roslyn_nvim_selected_solution, "list" }):wait()
                                        local csproj_files = vim.iter(vim.split(res.stdout, "\n"))
                                            :map(function(it)
                                                local fullpath = vim.fs.normalize(vim.fs.joinpath(solution_dir, it))
                                                if fullpath ~= solution_dir and vim.uv.fs_stat(fullpath) then
                                                    return fullpath
                                                else
                                                    return nil
                                                end
                                            end)
                                            :totable()

                                        return dap_utils.pick_process({
                                            filter = function(proc)
                                                return vim.iter(csproj_files):find(function(file)
                                                    if vim.endswith(proc.name, vim.fn.fnamemodify(file, ":t:r")) then
                                                        return true
                                                    end
                                                end)
                                            end,
                                        })
                                    end,
                                },
                            }
                        end
                    end
                end
            }
        },
    },
    {
        "jlcrochet/vim-razor",
        cond = not vim.g.vscode,
    },
    {
        "seblj/roslyn.nvim",
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filewatching = true,
        }
    }
}
