local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    { silent = true, desc = "Comment" })
vim.keymap.set("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { silent = true, desc = "Comment" })

comment.setup {
    pre_hook = function(ctx)

        if vim.bo.filetype == "typescriptreact"
            or vim.bo.filetype == "javascriptreact"
            or vim.bo.filetype == "javascript"
            or vim.bo.filetype == "typescript"
        then
            local U = require "Comment.utils"

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring {
                key = type,
                location = location,
            }
        end
    end,
}
