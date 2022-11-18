local icons = require("core.icons")
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = icons.dap.PackageInstalled,
            package_pending = icons.dap.PackagePending,
            package_uninstalled = icons.dap.PackageUninstalled,
        },
        border = "rounded"
    }
})
