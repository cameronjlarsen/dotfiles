local M = {

    lspkind = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
        Copilot = " ",
    },

    statusline_separators = {
        Default = {
            Left = "",
            Right = " ",
        },

        Round = {
            Left = "",
            Right = "",
        },

        Block = {
            left = "█",
            Right = "█",
        },

        Arrow = {
            Left = "",
            Right = "",
        },
    },

    git = {
        Added = " ",
        Changed = " ",
        Removed = " ",
        Branch = " ",
        Octoface = " ",
    },

    ui = {
        Telescope = " ",
        PackageInstalled = " ",
        PackagePending = " ",
        PackageUninstalled = " ",
        PackageError = " ",
        PackageMoved = " ",
        Tab = " ",
        Vim = " ",
        Term = " ",
    },

    diagnostics = {
        Error = " ",
        Warn = " ",
        Info = " ",
        Hint = " ",
        Question = " ",
    },

    dap = {
        Breakpoint = " ",
        BreakpointCondition = "ﳁ ",
        BreakpointRejected = " ",
        LogPoint = " ",
        Pause = " ",
        Play = " ",
        RunLast = "↻",
        StepBack = "",
        StepInto = "",
        StepOut = "",
        StepOver = " ",
        Stopped = " ",
        Terminate = "ﱢ ",
    },
}

return M
