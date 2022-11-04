local M = {}
M.lspkind = {
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
}

M.statusline_separators = {
    default = {
        left = "",
        right = " ",
    },

    round = {
        left = "",
        right = "",
    },

    block = {
        left = "█",
        right = "█",
    },

    arrow = {
        left = "",
        right = "",
    },
}

M.git = {
    added = " ",
    changed = " ",
    removed = " ",
    branch = " ",
    octoface = " ",
}

M.ui = {
    telescope = " ",
    package_installed = " ",
    package_pending = " ",
    package_uninstalled = " ",
    package_error = " ",
    package_moved = " "
}

M.diagnostics = {
    error = " ",
    warn = " ",
    info = " ",
    hint = " ",
    question = " ",
}

return M
