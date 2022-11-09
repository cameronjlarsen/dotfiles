local M = {}

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
        virtual_text = false,
        virtual_lines = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
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

local function lsp_highlight_document(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

local function lsp_keymaps(bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local tb_status_ok, tb = pcall(require, "telescope.builtin")
    if not tb_status_ok then
        vim.notify("Telescope lsp not loaded")
        return
    end

    local map = require("user.utils").map

    -- Movement
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
    map("n", "gd", tb.lsp_definitions, { desc = "Goto definition" })
    map("n", "gi", tb.lsp_implementations, { desc = "Goto implementation" })
    map("n", "gt", tb.lsp_type_definitions, { desc = "Goto type definition" })
    map("n", "gr", tb.lsp_references, { desc = "Goto references" })

    -- Code actions
    map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format Document" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
    map("n", "<leader>ll", vim.lsp.codelens.run, { desc = "CodeLens Action" })

    -- Diagnostics --
    map("n", "gl", vim.diagnostic.open_float, { desc = "Show Line Diagnostic" })
    map("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, { desc = "Prev Diagnostic" })
    map("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, { desc = "Next Diagnostic" })
    map("n", "[e",
        function() vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.ERROR }) end,
        { desc = "Prev Error" })
    map("n", "]e",
        function() vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.ERROR }) end,
        { desc = "Next Error" })
    map("n", "[w",
        function() vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.WARN }) end,
        { desc = "Prev Warning" })
    map("n", "]w",
        function() vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.WARN }) end,
        { desc = "Next Warning" })
    map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Send Diagnostics to Quickfix" })
    map("n", "<leader>ld", function() tb.diagnostics({ bufnr = 0 }) end, { desc = "Document Diagnostics" })
    map("n", "<leader>lwd", tb.diagnostics, { desc = "Workspace Diagnostics" })

    -- Docs
    map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover information" })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature_help" })
    map("n", "<leader>ls", function() tb.lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait",
                "Variable" },
        })
    end, { desc = "Document Symbols" })

    -- Workspaces
    map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add folder to workspace" })
    map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove folder from workspace" })
    map("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = "List workspace folders" })
    map("n", "<leader>lws", function() tb.lsp_dynamic_workspace_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait",
                "Variable" },
        })
    end, { desc = "Workspace Symbols" })
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
