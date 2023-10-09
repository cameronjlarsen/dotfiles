return {
    {
        "telescope.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            {
                "ahmedkhalf/project.nvim",
                cond = not vim.g.vscode,
                event = "VeryLazy",
                opts = {
                    active = true,
                    on_config_done = nil,
                    manual_mode = false,
                    detection_methods = { "pattern" },
                    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "gradlew",
                        "pom.xml",
                        "go.mod" },
                    show_hidden = false,
                    silent_chdir = true,
                    ignore_lsp = {},
                    datapath = vim.fn.stdpath("data"),
                },
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                    require("telescope").load_extension("projects")
                end
            },
        }
    },
}
