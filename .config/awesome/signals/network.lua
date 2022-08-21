local awful = require "awful"
local gears = require "gears"

local old_status = "reconnecting"
local old_conn_type = "type"

local function check_network()
    local script = [[
            nmcli g | awk 'NR == 2 {printf $1}'
        ]]

    awful.spawn.easy_async_with_shell(script, function(stdout)
        local status = tostring(stdout)

        if status:match("connected") then
            local get_conn_type = [[
                    nmcli -t connection show --active | awk 'NR == 1 {print $1}' 
                ]]

            awful.spawn.easy_async_with_shell(get_conn_type, function(stdout)
                local conn_type = tostring(stdout)
                if conn_type ~= old_conn_type then
                    awesome.emit_signal("signal::conn_type", conn_type)
                    old_conn_type = conn_type
                end
            end)
        end

        if status ~= old_status then -- Emit signal if there was a change
            awesome.emit_signal("signal::network", status)
            old_status = status
        end
    end
    )
end

check_network()

gears.timer {
    timeout = 3,
    autostart = true,
    call_now = true,
    callback = function()
        check_network()
    end,
}
