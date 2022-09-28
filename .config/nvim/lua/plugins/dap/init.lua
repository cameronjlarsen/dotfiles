local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
    return
end

-- Configure language adapters
require("plugins.dap.cpp")
require("plugins.dap.cs")
