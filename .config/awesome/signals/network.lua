local awful           = require "awful"
local gears           = require "gears"
local naughty         = require("naughty")
local widget_icon_dir = gears.filesystem.get_configuration_dir() .. "icons/network/"

local network_mode = nil
local interfaces   = {
    lan = "eno1",
    wlan = "wlan0"
}

local startup           = true
local reconnect_startup = true


local check_internet_health = "nmcli networking connectivty check"

local function update_startup()
    if startup then
        startup = false
    end
end

local function update_reconnect_startup(status)
    reconnect_startup = status
end

local function network_notify(message, title, app_name, icon)
    naughty.notification({
        message = message,
        title = title,
        app_name = app_name,
        icon = icon
    })
end

local function update_tooltip(message)
    awesome.emit_signal("network::tooltip", message)
end

local function update_widget_icon(icon)
    awesome.emit_signal("network::icon", icon)
end

local function update_wireless()

    network_mode = "wireless"

    -- Create wireless connection notification
    local function notify_connected(ssid)
        local message = "Connected to internet with <b>\"" .. ssid .. "\"</b>"
        local title = "Connection Established"
        local app_name = "System Notification"
        local icon = widget_icon_dir .. "wifi.svg"
        network_notify(message, title, app_name, icon)
    end

    -- Get wifi ssid and bitrate
    local function update_wireless_data(strength, healthy)
        awful.spawn.easy_async_with_shell(
            [[
            nmcli -t device wifi list | grep "*" | awk -F: '{print $8 ":" $11}'
            ]],
            function(stdout)
                local sep = stdout:find(":")
                local ssid = stdout:sub(1, sep) or "N/A"
                local bitrate = stdout:sub(sep, -1) or "N/A"
                local message = "Connected to: <b>" .. (ssid or "Loading...*") ..
                    "</b>\nWireless Interface: <b>" .. interfaces.wlan ..
                    "</b>\nWiFi-Strength: <b>" .. tostring(strength) .. "%" ..
                    "</b>\nBit rate: <b>" .. tostring(bitrate) .. "</b>"
                if healthy then
                    update_tooltip(message)
                else
                    update_tooltip("<b>Connected but no internet!</b>\n" .. message)
                end

                if reconnect_startup or startup then
                    notify_connected(ssid)
                    update_reconnect_startup(false)
                end
            end)
    end

    -- Update wifi icon based on wifi strength adn health
    local function update_wireless_icon(strength, rounded_strength)
        awful.spawn.easy_async_with_shell(
            check_internet_health,
            function(stdout)
                local widget_icon_name = "wifi-strength"
                if not stdout:match("none") then
                    if startup or reconnect_startup then
                        awesome.emit_signal("system::network_connected")
                    end
                    widget_icon_name = widget_icon_name .. "-" .. tostring(rounded_strength)
                    update_wireless_data(strength, true)
                else
                    widget_icon_name = widget_icon_name .. "-" .. tostring(rounded_strength) .. "-alert"
                    update_wireless_data(strength, false)
                end
                update_widget_icon(widget_icon_dir .. widget_icon_name .. ".svg")
            end)
    end

    -- Get wifi strength
    local update_wireless_strength = function()
        awful.spawn.easy_async_with_shell(
            [[
				awk 'NR==3 {printf "%3.0f" ,($3/70)*100}' /proc/net/wireless
				]]       ,
            function(stdout)
                if not tonumber(stdout) then
                    return
                end
                local wifi_strength = tonumber(stdout)
                local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
                update_wireless_icon(wifi_strength, wifi_strength_rounded)
            end
        )
    end

    update_wireless_strength()
    update_startup()
end

local function update_wired()

    network_mode = "wired"

    local function notify_connected()
        local message = "Connected to internet with <b>\"" .. interfaces.lan .. "\"</b>"
        local title = "Connection Established"
        local app_name = "System Notification"
        local icon = widget_icon_dir .. "wired.svg"
        network_notify(message, title, app_name, icon)
    end

    awful.spawn.easy_async_with_shell(
        check_internet_health,
        function(stdout)

            local widget_icon_name = "wired"

            if stdout:match("none") then
                widget_icon_name = widget_icon_name .. "-alert"
                update_tooltip(
                    "<b>Connected but no internet!</b>" ..
                    "\nEthernet Interface: <b>" .. interfaces.lan .. "</b>"
                )
            else
                update_tooltip("Ethernet Interface: <b>" .. interfaces.lan .. "</b>")
                if startup or reconnect_startup then
                    awesome.emit_signal("system::network_connected")
                    notify_connected()
                    update_startup()
                end
                update_reconnect_startup(false)
            end
            update_widget_icon(widget_icon_dir .. widget_icon_name .. ".svg")
        end
    )
end

local function update_disconnected()

    local function notify_wireless_disconnected()
        local message = "Wi-Fi network has been disconnected"
        local title = "Connection Disconnected"
        local app_name = "System Notification"
        local icon = widget_icon_dir .. "wifi-strength-off.svg"
        network_notify(message, title, app_name, icon)
    end

    local function notify_wired_disconnected()
        local message = "Ethernet network has been disconnected"
        local title = "Connection Disconnected"
        local app_name = "System Notification"
        local icon = widget_icon_dir .. "wired-off.svg"
        network_notify(message, title, app_name, icon)
    end

    local widget_icon_name = "wifi-strength-off"

    if network_mode == "wireless" then
        widget_icon_name = "wifi-strength-off"
        if not reconnect_startup then
            update_reconnect_startup(true)
            notify_wireless_disconnected()
        end
    elseif network_mode == "wired" then
        widget_icon_name = "wired-off"
        if not reconnect_startup then
            update_reconnect_startup(true)
            notify_wired_disconnected()
        end
    end
    update_tooltip("Network is currently disconnected")
    update_widget_icon(widget_icon_dir .. widget_icon_name .. ".svg")
end

local function check_network_mode()
    awful.spawn.easy_async_with_shell(
        [=[
        #!/usr/bin/bash
        wireless="wlan0"
        wired="eno1"
        net="/sys/class/net/"
        wired_state="down"
        wireless_state="down"
        network_mode=""
        # Check network state based on interface"s operstate value
        check_network_state() {
          # Check what interface is up
          if [ "${wired_state}" = "up" ];
          then
            network_mode="wired"
          elif [ "${wireless_state}" = "up" ];
          then
            network_mode="wireless"
          else
            network_mode="No internet connection"
          fi
        }
        # Check if network directory exist
        check_network_directory() {
          if [ -n "${wireless}" ] && [ -d "${net}${wireless}" ];
          then
            wireless_state="$(cat "${net}${wireless}/operstate")"
          fi
          if [ -n "${wired}" ] && [ -d "${net}${wired}" ]; then
            wired_state="$(cat "${net}${wired}/operstate")"
          fi
          check_network_state
        }
        # Start script
        print_network_mode() {
          # Call to check network dir
          check_network_directory
          # Print network mode
          printf "${network_mode}"
        }
        print_network_mode
            ]=],
        function(stdout)
            local mode = stdout:gsub("%\n", "")
            if mode:match("No internet connection") then
                update_disconnected()
            elseif mode:match("wireless") then
                update_wireless()
            elseif mode:match("wired") then
                update_wired()
            end
        end)
end

check_network_mode()

gears.timer {
    timeout = 3,
    autostart = true,
    call_now = true,
    callback = function()
        check_network_mode()
    end,
}
