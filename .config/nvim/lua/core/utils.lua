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

return M
