local icons = { ui = require("core.icons").get("ui") }
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = icons.ui.PackageInstalled,
            package_pending = icons.ui.PackagePending,
            package_uninstalled = icons.ui.PackageUninstalled,
        },
        border = "rounded"
    }
})
