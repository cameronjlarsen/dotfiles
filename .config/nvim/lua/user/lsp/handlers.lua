local M = {}

-- TODO: backfill this to template
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = true,
        virtual_lines = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style     = "minimal",
            border    = "rounded",
            source    = "always",
            header    = "",
            prefix    = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]       ,
            false
        )
    end
end

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts, { silent = true, buffer = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

local function lsp_keymaps(bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "goto declaration" })
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "goto definition" })
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "LSP hover information" })
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "goto implementation" })
    map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "LSP signature_help" })
    map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "goto references" })
    map({ "n", "v" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
    map("n", "<leader>lR", "<cmd>lua vim.lsp.codelens.run()<CR>", { desc = "CodeLens Action" })
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show Line Diagnostic" })
    map(
        "n",
        "<leader>lk",
        '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
        { desc = "Prev Diagnostic" }
    )
    map(
        "n",
        "<leader>lj",
        '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
        { desc = "Next Diagnostic" }
    )
    map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Send Diagnostics to Quickfix" })
    map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = "Format Document" })
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
