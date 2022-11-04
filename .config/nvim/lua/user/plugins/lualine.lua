---@diagnostic disable: missing-parameter, unused-local
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local icons = require("user.plugins.icons")
local sep_style = "default"
local separators = icons.statusline_separators
local sep_l = separators[sep_style].left
local sep_r = separators[sep_style].right

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local mode = {
    "mode",
    fmt = function(str)
        return " " .. str
    end,
    icons_enabled = true,
    separator = { right = sep_r }
}

local filetype = {
    "filetype",
    icon_only = true,
    colored = false,
    padding = 0,
    separator = { right = sep_r }
}

local filename = {
    "filename",
    fmt = function()
        return vim.fn.expand("%:t:r")
    end,
    path = 0,
    symbols = {
        modified = "",
        readonly = "",
        unnamed = "",
        newfile = "",
    },
    file_status = false,
    separator = { right = sep_r }
}

-- Git
local branch = {
    "branch",
    icon = icons.git.branch,
    padding = { left = 0, right = 1 },
    separator = { right = sep_r }
}

local diff = {
    "diff",
    colored = true,
    symbols = {
        added = icons.git.added,
        modified = icons.git.changed,
        removed = icons.git.removed,
    },
    cond = hide_in_width,
    separator = { right = sep_r }
}

local location = {
    "location",
    padding = { right = 1 },
    separator = { left = sep_l },
}

local progress = {
    "progress",
    ---@diagnostic disable-next-line: unused-local
    fmt = function(str)
        return "%P/%L"
    end,
    separator = { left = sep_l, right = separators.round.right },
}

local spaces = {
    function()
        return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end,
    separator = { left = sep_l },
}

-- LSP
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = {
        error = icons.diagnostics.error,
        warn = icons.diagnostics.warn,
        info = icons.diagnostics.info,
        hint = icons.diagnostics.hint,
    },
    cond = hide_in_width,
    colored = true,
    update_in_insert = false,
    always_visible = false,
}

local lsp = {
    function()
        local icon = "  "
        local msg = "LSP Inactive"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        local client_names = {}
        local copilot_active = false

        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if client.name ~= "copilot" and client.name ~= "null-ls" then
                    table.insert(client_names, client.name)
                end
                if client.name == "copilot" then
                    copilot_active = true
                end
            end
        end

        -- add formatter
        local s = require("null-ls.sources")
        local available_sources = s.get_available(buf_ft)
        local registered = {}
        for _, source in ipairs(available_sources) do
            for method in pairs(source.methods) do
                registered[method] = registered[method] or {}
                table.insert(registered[method], source.name)
            end
        end

        local formatter = registered["NULL_LS_FORMATTING"]
        local linter = registered["NULL_LS_DIAGNOSTICS"]
        if formatter ~= nil then
            vim.list_extend(client_names, formatter)
        end
        if linter ~= nil then
            vim.list_extend(client_names, linter)
        end

        -- join client names with commas
        local client_names_str = table.concat(client_names, ", ")

        local language_servers = ""
        local client_names_str_len = #client_names_str
        if client_names_str_len ~= 0 then
            language_servers = icon .. client_names_str
        end
        if copilot_active then
            language_servers = language_servers .. icons.git.octoface
        end

        if client_names_str_len == 0 and not copilot_active then
            return ""
        else
            return language_servers
        end
    end,
    cond = hide_in_width,
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "Outline", "lspinfo", "mason", "checkhealth", },
        ignore_focus = { "NvimTree" },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { filetype, filename, },
        lualine_c = { branch, diff },
        lualine_x = { diagnostics, lsp },
        lualine_y = { spaces },
        lualine_z = { progress },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filetype, filename },
        lualine_x = { progress },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
