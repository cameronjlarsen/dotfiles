local status_ok, leetbuddy = pcall(require, "leetbuddy")
if not status_ok then
    return
end

leetbuddy.setup({
    domain = "com",
    language = "py",
})
