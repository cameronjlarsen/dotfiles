local M = {}
function M.map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
