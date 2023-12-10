return {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring")
                    .calculate_commentstring() or vim.bo.commentstring
            end,
        }
    }
}
