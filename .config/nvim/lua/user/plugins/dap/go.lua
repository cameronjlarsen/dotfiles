local dap_go_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_status_ok then
    return
end

dap_go.setup()
