local icons = require("core.icons")
local conditions = require("plugins.lualine.conditions")
local sep_style = "Default"
local separators = icons.statusline_separators
local sep_l = separators[sep_style].Left
local sep_r = separators[sep_style].Right

-- check if value in table
local function contains(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

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

return {
    mode = {
        "mode",
        fmt = function(str)
            return icons.ui.Vim .. str
        end,
        icons_enabled = true,
        separator = { right = sep_r }
    },

    filetype = {
        "filetype",
        icon_only = true,
        colored = true,
        padding = 0,
        separator = { right = sep_r }
    },

    filename = {
        "filename",
        fmt = function(str)
            local ui_filetypes = {
                "help",
                "packer",
                "neogitstatus",
                "NvimTree_1",
                "Trouble",
                "lir",
                "Outline",
                "spectre_panel",
                "toggleterm",
                "DressingSelect",
                "",
                "nil",
            }

            if contains(ui_filetypes, str) or contains(ui_filetypes, vim.bo.filetype) then
                return " "
            else
                return vim.fn.expand("%:t:r")
            end
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
    },

    -- Git
    branch = {
        "branch",
        icons_enabled = true,
        icon = icons.git.Branch,
        colored = true,
        padding = { left = 0, right = 1 },
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
            return icons.ui.Tab .. " " .. shiftwidth
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
            local clients = vim.lsp.get_active_clients()
            local client_names = {}
            local copilot_active = false

            -- add client
            for _, client in ipairs(clients) do
                if client.name ~= "copilot" and client.name ~= "null-ls" then
                    table.insert(client_names, client.name)
                end
                if client.name == "copilot" then
                    copilot_active = true
                end
            end

            -- add formatter
            local formatters = require("lsp.providers.null-ls.formatters")
            local registered_formatters = formatters.list_registered(buf_ft)
            vim.list_extend(client_names, registered_formatters)

            -- add linter
            local linters = require("lsp.providers.null-ls.linters")
            local registered_linters = linters.list_registered(buf_ft)
            vim.list_extend(client_names, registered_linters)

            -- get unique names
            local unique_client_names = vim.fn.uniq(client_names)

            -- join client names with commas
            local client_names_str = table.concat(unique_client_names, ", ")

            local language_servers = ""
            local client_names_str_len = #client_names_str
            if client_names_str_len ~= 0 then
                language_servers = "%#SLLSPIcon#" .. icon .. "%*" .. client_names_str
            end
            if copilot_active then
                language_servers = language_servers .. " " .. "%#SLCopilot#" .. icons.git.Octoface
            end

            if client_names_str_len == 0 and not copilot_active then
                return ""
            else
                return language_servers
            end
        end,
        cond = conditions.hide_in_width,
    }
}
