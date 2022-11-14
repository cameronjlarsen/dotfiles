local name = "catppuccin"

local status_ok, _ = pcall(require, "user.core.colorscheme." .. name)
if not status_ok then
    vim.notify("whoops! colorscheme " .. name .. " not found!")
    return
else
    vim.cmd.colorscheme("catppuccin")
end
