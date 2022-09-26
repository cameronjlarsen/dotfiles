local status_ok, markdownflow = pcall(require, "mkdnflow")
if not status_ok then
    return
end

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>kmm", "<cmd>MarkdownPreview<cr>", { desc = "Start Markdown Preview" })
map("n", "<leader>kms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown Preview" })
map("n", "<leader>kmp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown Preview" })

markdownflow.setup()
