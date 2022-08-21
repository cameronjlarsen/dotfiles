local awful = require "awful"
local gears = require "gears"

local old_strength = -1

local function get_wifi()
    local get_strength = [[
			awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
			]]

    awful.spawn.easy_async_with_shell(get_strength, function(stdout)
        local strength = tonumber(stdout)

        -- Emit a signal if the wifi strength changes
        if strength ~= nil then
            if strength ~= old_strength then
                awesome.emit_signal("signal::wifi", strength)
                old_strength = strength
            end
        end
    end)
end

gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function() get_wifi() end
}
