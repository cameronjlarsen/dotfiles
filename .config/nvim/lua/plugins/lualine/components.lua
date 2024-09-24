local icons = {
    ui = require("core.icons").get("ui", true),
    _ui = require("core.icons").get("ui"),
    git = require("core.icons").get("git", true),
    diagnostics = require("core.icons").get("diagnostics", true),
    separators = require("core.icons").get("statusline_separators"),
}
local conditions = require("plugins.lualine.conditions")
local sep_style = "Default"
local separators = icons.separators
local sep_l = separators[sep_style].Left
local sep_r = separators[sep_style].Right
local filetype = require("lualine.components.filetype"):extend()
local modules = {
    highlight = require("lualine.highlight"),
    utils = require("lualine.utils.utils")
}
local get_colors = modules.utils.extract_highlight_colors

local function diff_source()
    ---@diagnostic disable-next-line: undefined-field
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function get_toggleterm_name()
    local shell = vim.fn.fnamemodify(vim.env.SHELL, ':t')
    return string.format('Terminal(%s)[%s]', shell, vim.api.nvim_buf_get_var(0, 'toggle_number'))
end

local exceptions = {
    names = {
        ["orgagenda"] = "Org",
        ["mail"] = "Mail",
        ["minimap"] = "",
        ["dbui"] = "Dadbod UI",
        ["tsplayground"] = "Treesitter",
        ["query"] = "Treesitter",
        ["Trouble"] = "Lsp Trouble",
        ["gitcommit"] = "Git Commit",
        ["help"] = "help",
        ["undotree"] = "UndoTree",
        ["octo"] = "Octo",
        ["NvimTree"] = "Nvim Tree",
        ["dap-repl"] = "Debugger REPL",
        ["neo-tree"] = "Neo Tree",
        ["toggleterm"] = get_toggleterm_name,
        ["TelescopePrompt"] = "Telescope",
        ["qf"] = "Quickfix List",
    },
}

function filetype:init(options)
    filetype.super.init(self, options)
    self.options = options or {}
    self.icon_hl_cache = {}
end

function filetype:update_status()
    local ft = vim.bo.filetype or ""
    return modules.utils.stl_escape(ft)
end

function filetype:apply_icon()
    if not self.options.icons_enabled then
        return
    end

    local icon, icon_highlight_group
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
        icon, icon_highlight_group = devicons.get_icon(vim.bo.filetype)
        if icon == nil then
            icon, icon_highlight_group = devicons.get_icon(vim.fn.expand("%:t"))
            if icon == nil then
                icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
            end
        end

        if icon == nil and icon_highlight_group == nil then
            icon = ""
            icon_highlight_group = "DevIconDefault"
        end
        if self.options.colored then
            local highlight_color = modules.utils.extract_highlight_colors(icon_highlight_group, "fg")
            if highlight_color then
                local default_highlight = self:get_default_hl()
                local icon_highlight = self.icon_hl_cache[highlight_color]
                if not icon_highlight or not modules.highlight.highlight_exists(icon_highlight.name .. "_normal") then
                    icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
                    self.icon_hl_cache[highlight_color] = icon_highlight
                end

                icon = self:format_hl(icon_highlight) .. icon .. default_highlight
            end
        end
    else
        ---@diagnostic disable-next-line: cast-local-type
        ok = vim.fn.exists("*WebDevIconsGetFileTypeSymbol")
        if ok ~= 0 then
            icon = vim.fn.WebDevIconsGetFileTypeSymbol()
        end
    end

    if not icon then
        return
    end

    if self.options.icon_only then
        self.status = icon
    elseif type(self.options.icon) == "table" and self.options.icon.align == "right" then
        self.status = self.status .. " " .. icon
    else
        self.status = icon .. " " .. self.status
    end
end

local M = {}
M = {
    mode = {
        "mode",
        icon = icons._ui.Vim,
        icons_enabled = true,
        separator = { right = sep_r }
    },
    filetype = {
        filetype,
        icon_only = true,
        icons_enabled = true,
        colored = true,
        padding = { left = 1, right = 0 },
        separator = { right = sep_r },
    },
    filename = {
        "filename",
        fmt = function(str)
            local ft = vim.bo.filetype
            if str:match("toggleterm") and (str ~= "toggleterm.lua") then
                return get_toggleterm_name()
            elseif exceptions.names[ft] then
                return exceptions.names[ft]
            else
                return vim.fn.expand("%:t")
            end
        end,
        path = 0,
        symbols = {
            modified = icons.ui.Modified,
            readonly = icons.ui.Lock,
            unnamed = " ",
            newfile = icons.ui.NewFile,
        },
        file_status = true,
        separator = { right = sep_r }
    },
    -- Git
    branch = {
        "branch",
        icons_enabled = true,
        icon = icons.ui.GitHub,
        colored = true,
        separator = { right = sep_r }
    },
    diff = {
        "diff",
        source = diff_source,
        colored = true,
        symbols = {
            added = icons.git.Added,
            modified = icons.git.Changed,
            removed = icons.git.Removed,
        },
        cond = conditions.hide_in_width,
        separator = { right = sep_r }
    },
    location = {
        "location",
        padding = { right = 1 },
        separator = { left = sep_l },
    },
    progress = {
        "progress",
        ---@diagnostic disable-next-line: unused-local
        fmt = function(str)
            return "%P/%L"
        end,
        separator = { left = sep_l },
    },
    spaces = {
        function()
            local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
            return icons.ui.Tab .. shiftwidth
        end,
        separator = { left = sep_l },
    },
    -- LSP
    diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
        },
        cond = conditions.hide_in_width,
        colored = true,
        update_in_insert = false,
        always_visible = false,
    },
    lsp = {
        function()
            local icon = icons.ui.LSP
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local client_names = {}

            -- add client
            for _, client in ipairs(clients) do
                if client.name ~= "copilot" and client.name ~= "null-ls" then
                    table.insert(client_names, client.name)
                end
            end

            -- add formatter
            local formatters = require("plugins.null-ls.formatters")
            local registered_formatters = formatters.list_registered(buf_ft)
            vim.list_extend(client_names, registered_formatters, 1, #registered_formatters)

            -- add linter
            local linters = require("plugins.null-ls.linters")
            local registered_linters = linters.list_registered(buf_ft)
            vim.list_extend(client_names, registered_linters, 1, #registered_linters)

            -- get unique names
            local unique_client_names = vim.fn.uniq(client_names)

            -- join client names with commas
            ---@diagnostic disable-next-line: param-type-mismatch
            local client_names_str = table.concat(unique_client_names, ", ")

            local language_servers = ""
            local client_names_str_len = #client_names_str
            if client_names_str_len ~= 0 then
                language_servers = "%#SLLSPIcon#" .. icon .. "%*" .. client_names_str
            end

            if client_names_str_len == 0 then
                return "%#GitSignsDelete#" .. icon .. "%*" .. "No Active LSP"
            else
                return language_servers
            end
        end,
    },
    copilot = {
        function()
            return require("copilot_status").status_string()
        end,
        cnd = function()
            return require("copilot_status").enabled()
        end,
        color = function()
            local status = require("copilot_status").status().status
            if status == "offline" or status == "error" then
                return { fg = get_colors("GitSignsDelete", "fg") }
            elseif status == "warning" then
                return { fg = get_colors("GitSignsChange", "fg") }
            else
                return { fg = get_colors("GitSignsAdd", "fg") }
            end
        end
    },
    treesitter = {
        function()
            return icons._ui.Tree
        end,
        color = function()
            local buf = vim.api.nvim_get_current_buf()
            local ts = vim.treesitter.highlighter.active[buf]
            return {
                fg = ts and (not vim.tbl_isempty(ts)) and get_colors("GitSignsAdd", "fg") or
                    get_colors("GitSignsDelete", "fg")
            }
        end,
        cond = conditions.hide_in_width,
    },
}

return M
