---@diagnostic disable: missing-parameter
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = "", hint = "" },
    colored = true,
    update_in_insert = false,
    always_visible = false,
}

local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

local mode = {
    "mode",
    fmt = function(str)
        return str
    end,
}

local filetype = {
    "filetype",
    separator = { left = "" },
    icon_only = true,
    colored = false,
}

local branch = {
    "branch",
    icon = "",
}

local location = {
    "location",
    padding = 0
}

local progress = {
    -- function()
    -- 	local current_line = vim.fn.line(".")
    -- 	local total_lines = vim.fn.line("$")
    -- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    -- 	local line_ratio = current_line / total_lines
    -- 	local index = math.ceil(line_ratio * #chars)
    -- 	return chars[index]
    -- end,
    "progress",
---@diagnostic disable-next-line: unused-local
    fmt = function(str)
        return "%P/%L"
    end,
    separator = { right = "" },
}

local spaces = function()
    return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp = {
    function()
        local icon = [[  ]]
        local msg = "LSP Inactive"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        local client_names = {}

        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if client.name ~= "null-ls" then
                    table.insert(client_names, client.name)
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
            language_servers = icon .. "(" .. client_names_str .. ")"
        end

        if client_names_str_len == 0 then
            return icon .. msg
        else
            return language_servers
        end
    end,
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { filetype, mode },
        lualine_b = { branch, diff },
        lualine_c = { diagnostics },
        lualine_x = { lsp },
        lualine_y = { spaces, "encoding" },
        lualine_z = { location, progress },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
