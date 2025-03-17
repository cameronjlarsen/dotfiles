return {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
        "MasonUpdate",
    },
    keys = {
        { "<leader>lm", function() vim.cmd("Mason") end, silent = true, desc = "Mason Info" },
    },
    opts = function()
        local icons = { ui = require("core.icons").get("ui") }

        return {
            ui = {
                icons = {
                    package_installed = icons.ui.PackageInstalled,
                    package_pending = icons.ui.PackagePending,
                    package_uninstalled = icons.ui.PackageUninstalled,
                },
                border = "rounded"
            }
        }
    end,
    build = ":MasonUpdate",
}
