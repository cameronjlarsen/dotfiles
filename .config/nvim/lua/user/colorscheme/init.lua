local name = "catppuccin"

pcall(require, "user.colorscheme" .. name)

---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. name)
if not status_ok then
    vim.notify("colorscheme " .. name .. " not found!")
    return
end
