local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then
    return
end
local icons = require("core.icons")
local get_color = require("core.utils").get_hl_colors

devicons.setup({
    override = {
            ["diff"] = {
            color = get_color("GitSignsDelete", "fg"),
            cterm_color = 196,
        },
            ["diffviewfiles"] = {
            icon = icons.git.Diff,
            color = get_color("GitSignsDelete", "fg"),
            cterm_color = 196,
            name = "DiffviewFiles",
        },
            ["diffviewfilehistorypanel"] = {
            icon = icons.git.Diff,
            color = get_color("GitSignsChange", "fg"),
            cterm_color = 196,
            name = "DiffviewFileHistoryPanel",
        },
            ["tsplayground"] = {
            icon = icons.ui.Tree_Alt,
            color = get_color("GitSignsAdd", "fg"),
            cterm_color = 81,
            name = "TSPlayground",
        },
            ["lazygit"] = {
            icon = icons.ui.Git,
            color = get_color("GitSignsDelete", "fg"),
            cterm_color = 196,
            name = "LazyGit",
        },
            ["help"] = {
            icon = icons.ui.Help,
            color = "#89e051",
            cterm_color = 113,
            name = "Help"
        },
            ["undotree"] = {
            icon = icons.ui.FileTree,
            color = "#89e051",
            cterm_color = 113,
            name = "UndoTree"
        },
            ["nvimtree_1"] = {
            icon = icons.ui.FileTree,
            color = "#89e051",
            cterm_color = 113,
            name = "NvimTree"
        },
            ["toggleterm"] = {
            icon = icons.ui.Term,
            color = "#31B53E",
            cterm_color = 34,
            name = "ToggleTerm"
        },
            ["qf"] = {
            icon = icons.ui.Wand,
            color = "#89e051",
            cterm_color = 113,
            name = "QuickFix"
        },
            ["telescopeprompt"] = {
            icon = icons.ui.Telescope,
            color = "#89e051",
            cterm_color = 113,
            name = "TelescopePrompt"
        },
            ["[dap-repl]"] = {
            icon = icons.ui.Term,
            color = "#31B53E",
            cterm_color = 34,
            name = "DAPRepl"
        },
            ["dapui_console"] = {
            icon = icons.ui.DebugConsole,
            color = get_color("DAPUIValue", "fg"),
            cterm_color = 34,
            name = "DAPUIConsole"
        },
            ["dapui_watches"] = {
            icon = icons.ui.Watches,
            color = get_color("DAPUIWatchesValue", "fg"),
            cterm_color = 34,
            name = "DAPUIWatches"
        },
            ["dapui_stacks"] = {
            icon = icons.ui.Stacks,
            color = get_color("DAPUISource", "fg"),
            cterm_color = 34,
            name = "DAPUIStacks"
        },
            ["dapui_breakpoints"] = {
            icon = icons.dap.Breakpoint,
            color = get_color("DapBreakpoint", "fg"),
            cterm_color = 34,
            name = "DAPUIBreakpoints"
        },
            ["dapui_scopes"] = {
            icon = icons.ui.Scopes,
            color = get_color("DAPUIScope", "fg"),
            cterm_color = 34,
            name = "DAPUIScopes"
        },
    }
})
