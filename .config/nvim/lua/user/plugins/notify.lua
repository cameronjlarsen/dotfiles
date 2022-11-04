local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end
notify.setup({
    background_colour = "#1E1E2E",
})

vim.notify = notify
