local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
    return
end

-- Configure language adapters
require("user.plugins.dap.cpp")
require("user.plugins.dap.cs")
require("user.plugins.dap.python")

require("user.plugins.dap.ui")
