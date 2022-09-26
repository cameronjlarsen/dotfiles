local status_ok, lsplines = pcall(require, "lsp_lines")
if not status_ok then
    return
end

vim.keymap.set({ "n", "v" }, "<Leader>ll", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

lsplines.setup()
