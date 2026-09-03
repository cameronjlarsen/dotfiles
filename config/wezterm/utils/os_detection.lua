local wezterm = require("wezterm")

local M = {}

local os_mapping = {
    ["x86_64-pc-windows-msvc"] = "Windows",
    ["x86_64-unknown-linux-gnu"] = "Linux",
    ["aarch64-unknown-linux-gnu"] = "Linux",
    ["aarch64-apple-darwin"] = "Darwin",
    ["x86_64-apple-darwin"] = "Darwin",
}

function M.get_current_os()
    return os_mapping[wezterm.target_triple] or "Unknown"
end

function M.enable_wayland()
    local wayland = os.getenv("XDG_SESSION_TYPE")
    if wayland == "wayland" then
        return true
    else
        return false
    end
end

-- Make the module callable
return setmetatable(M, {
    __call = function(_, config)
        return config
    end
})

