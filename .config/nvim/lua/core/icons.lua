local icons = {}

local data = {
    kind = {
        Text = "󰉿",
        Method = "m",
        Function = "󰊕",
        Constructor = "",
        Field = "",
        Variable = "󰆧",
        Class = "󰌗",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰇽",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Copilot = "",
    },
    statusline_separators = {
        Default = {
            Left = "",
            Right = "",
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
        Added = "",
        Changed = "󰛿",
        Removed = "",
        Diff = "",
        Repo = "",
        Branch = "",
    },
    ui = {
        Bug = "",
        Stacks = "",
        Scopes = "",
        Watches = "󰂥",
        Search = " ",
        DebugConsole = "",
        Database = "",
        Calendar = "",
        Mail = "󰇮",
        LSP = "󰅡",
        LSP_Alt = "󰘽",
        Check = "󰄳",
        NewFile = "󰎔",
        Modified = "󰛿",
        Modified_Alt = "",
        FileTree = "󰙅",
        Lock = "󰌾",
        Help = "",
        Lightbulb = "",
        NoteBook = "󰠮",
        Git = "",
        GitHub = "",
        PackageInstalled = "",
        PackagePending = "",
        PackageUninstalled = "",
        PackageError = "",
        PackageMoved = "",
        Stethescope = "",
        Tab = "󰌒",
        Telescope = "",
        Target = "󰀘",
        Term = "",
        Tree = "",
        Tree_Alt = "󰔱",
        Vim = "",
        Wand = "󰁨",
        Close = "󰅖",
        Close_Alt = "",
        Close_Circle_Filled = "󰅙",
        Close_Circle_Empty = "󰅚",
        Arrow_Left = "",
        Arrow_Right = "",
        Arrow_Up = "",
        Arrow_Down = "",
        Arrow_Circle_Left = "",
        Arrow_Circle_Right = "",
        Arrow_Circle_Up = "",
        Arrow_Circle_Down = "",
        Circle = "",
        Octoface = "" ,
    },
    diagnostics = {
        Error = "",
        Warn = "",
        Info = "",
        Hint = "󰌵",
        Question = "",
    },
    dap = {
        Breakpoint = "󰝥",
        BreakpointCondition = "󰟃",
        BreakpointRejected = "",
        LogPoint = "",
        Pause = "",
        Play = "",
        RunLast = "↻",
        StepBack = "",
        StepInto = "󰆹",
        StepOut = "󰆸",
        StepOver = "󰆷",
        Stopped = "",
        Terminate = "󰝤",
    },
}

---Get an icon from the specified category
---@param category "kind" | "statusline_separators" | "git" | "ui" | "diagnostics" | "dap"
---@param add_space? boolean @Add trailing space after the icon.
---@return table
function icons.get(category, add_space)
    if add_space then
        return setmetatable({}, {
            __index = function(_, key)
                return data[category][key] .. " "
            end,
        })
    else
        return data[category]
    end
end

return icons
