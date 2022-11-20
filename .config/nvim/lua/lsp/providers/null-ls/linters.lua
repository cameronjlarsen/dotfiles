local M = {}

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local services = require("lsp.providers.null-ls.services")
local alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

function M.list_registered(filetype)
    local registered_providers = services.list_registered_providers_names(filetype)
    local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
        return registered_providers[m] or {}
    end, alternative_methods))

    return providers_for_methods
end

function M.list_supported(filetype)
    local s = require "null-ls.sources"
    local supported_linters = s.get_supported(filetype, "diagnostics")
    table.sort(supported_linters)
    return supported_linters
end

return M
