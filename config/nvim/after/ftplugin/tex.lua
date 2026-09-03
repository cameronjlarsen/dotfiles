vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.textwidth = 120

local map = Utils.map
-- VimTeX --
map("n", "<leader>vi", "<plug>(vimtex-info)", { desc = "Info" })
map("n", "<leader>vI", "<plug>(vimtex-info-full)", { desc = "Full Info" })
map("n", "<leader>vt", "<plug>(vimtex-toc-open)", { desc = "Open TOC" })
map("n", "<leader>vT", "<plug>(vimtex-toc-toggle)", { desc = "Toggle TOC" })
map("n", "<leader>vq", "<plug>(vimtex-log)", { desc = "Log" })
map("n", "<leader>vv", "<plug>(vimtex-view)", { desc = "View" })
map("n", "<leader>vr", "<plug>(vimtex-reverse-search)", { desc = "Reverese Search" })
map("n", "<leader>vl", "<plug>(vimtex-compile)", { desc = "Compile" })
map({ "n", "x" }, "<leader>vL", "<plug>(vimtex-compile-selected)", { desc = "Compile Selected" })
map("n", "<leader>vk", "<plug>(vimtex-stop)", { desc = "Stop" })
map("n", "<leader>vK", "<plug>(vimtex-stop-all)", { desc = "Stop All" })
map("n", "<leader>ve", "<plug>(vimtex-erros)", { desc = "Erros" })
map("n", "<leader>vo", "<plug>(vimtex-compile-output)", { desc = "Compile Output" })
map("n", "<leader>vg", "<plug>(vimtex-status)", { desc = "Status" })
map("n", "<leader>vG", "<plug>(vimtex-status-all)", { desc = "Status All" })
map("n", "<leader>vc", "<plug>(vimtex-clean)", { desc = "Clean" })
map("n", "<leader>vC", "<plug>(vimtex-clean-full)", { desc = "Clean Full" })
map("n", "<leader>vm", "<plug>(vimtex-imaps-list)", { desc = "Imaps List" })
map("n", "<leader>vx", "<plug>(vimtex-reload)", { desc = "Reload" })
map("n", "<leader>vX", "<plug>(vimtex-reload-state)", { desc = "Reload State" })
map("n", "<leader>vs", "<plug>(vimtex-toggle-main)", { desc = "Toggle Main" })
map("n", "<leader>va", "<plug>(vimtex-context-menu)", { desc = "Context Menu" })

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    print("which-key not loaded")
    return
end

wk.register({
    ["<leader>"] = {
        v = { name = "+VimTeX" },
    }
})
