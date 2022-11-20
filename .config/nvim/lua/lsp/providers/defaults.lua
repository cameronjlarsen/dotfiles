local M = {}

function M.on_attach(client, bufnr)
    -- Configure keymaps
    require("lsp.keymaps").setup(client, bufnr)

    -- Configure highlighting
    require("lsp.highlighter").setup(client, bufnr)

    -- Configure formatting
    require("lsp.providers.null-ls.formatters").setup(client, bufnr)
end

function M.common_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities(capabilities)
    end

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    return capabilities
end

M.default_config = {
    on_attach = M.on_attach,
    capabilities = M.common_capabilities(),
    flags = {
        debounce_text_changes = 150,
    }
}

return M
