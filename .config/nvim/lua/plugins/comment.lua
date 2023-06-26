return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
        pre_hook = function() require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook() end,
    }
}
