local status_ok, dev = pcall(require, "neodev")
if not status_ok then
    return
end

---@diagnostic disable-next-line: missing-parameter
dev.setup()
