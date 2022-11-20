local M = {}

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local services = require("lsp.providers.null-ls.services")
local sources = require("null-ls.sources")
local method = null_ls.methods.FORMATTING

function M.has_formatter(filetype)
    local available = sources.get_available(filetype, method)
    return #available > 0
end

function M.list_registered(filetype)
    local registered_providers = services.list_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

function M.list_supported(filetype)
    local supported_formatters = sources.get_supported(filetype, "formatting")
    table.sort(supported_formatters)
    return supported_formatters
end

function M.setup(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    local enable = false
    if M.has_formatter(filetype) then
        enable = client.name == "null-ls"
    else
        enable = not (client.name == "null-ls")
    end

    if not enable then
        return
    end

    client.server_capabilities.documentFormattingProvider = enable
    client.server_capabilities.documentRangeFormattingProvider = enable
end

return M
