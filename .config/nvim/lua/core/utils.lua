local M = {}
function M.map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.toggle_virtual_text()
    local new_value = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_text = not new_value,
        virtual_lines = new_value,
    })
end

local diagnostics_active = true
function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

-- check if value in table
function M.contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- check if value is part of a key in a table
function M.matches(table, element)
    for key, _ in pairs(table) do
        if string.match(key, element) then
            return true
        end
    end
    return false
end

function M.get_hl_colors(color_group, scope)
    if vim.fn.hlexists(color_group) == 0 then
        return nil
    end

    local color = vim.api.nvim_get_hl(0, { name = color_group, link = false })
    if color.background ~= nil then
        color.bg = string.format('#%06x', color.background)
        color.background = nil
    end
    if color.foreground ~= nil then
        color.fg = string.format('#%06x', color.foreground)
        color.foreground = nil
    end
    if color.special ~= nil then
        color.sp = string.format('#%06x', color.special)
        color.special = nil
    end
    if scope then
        return color[scope]
    end
    return color
end

return M
