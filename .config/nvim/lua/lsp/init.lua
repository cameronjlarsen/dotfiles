local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

local map = vim.keymap.set

map("n", "<leader>li", "<cmd>LspInfo<cr>", { silent = true, desc = "Info" })
map("n", "<leader>lI", "<cmd>Mason<cr>", { silent = true, desc = "Installer Info" })

require("lsp.mason-lspconfig")
require("lsp.handlers").setup()
require("lsp.null-ls")
