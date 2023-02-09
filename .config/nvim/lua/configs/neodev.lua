local status_ok, dev = pcall(require, "neodev")
if not status_ok then
    return
end

dev.setup({
    library = {
        plugins =
        {
            "nvim-dap-ui",
        },
        types = true
    },
})
