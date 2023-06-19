local status_ok, duck = pcall(require, "duck")
if not status_ok then
    return
end
duck.setup({
    character = "👻"
})

vim.keymap.set("n", "<leader>Dd", function() duck.hatch() end, { desc = "Hatch a duck" })
vim.keymap.set("n", "<leader>Dk", function() duck.cook() end, { desc = "Cook a duck" })

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
    return
end

wk.register({
    D = { name = "Duck", },
}, { prefix = "<leader>" })
