local status_ok, dev = pcall(require, "lua-dev")
if not status_ok then
    return
end

dev.setup()
