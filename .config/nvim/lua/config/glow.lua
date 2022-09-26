local status_ok, glow = pcall(require, "glow")
if not status_ok then
    return
end

vim.keymap.set("n", "<leader>kmg", "<cmd>Glow<cr>", { silent = true, desc = "Glow Preview" })

glow.setup({
    style = "dark",
    width = 120,
})
