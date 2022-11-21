local M = {}


local function keymaps(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local caps = client.server_capabilities
    local map = require("core.utils").map
    local tb_status_ok, telescope = pcall(require, "telescope.builtin")
    if not tb_status_ok then
        vim.notify("Telescope lsp not loaded")
        return
    end


    -- Movement
    if caps.declarationProvider then
        map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
    end
    if caps.definitionProvider then
        map("n", "gd", telescope.lsp_definitions, { desc = "Goto definition" })
    end
    if caps.implementationProvider then
        map("n", "gi", telescope.lsp_implementations, { desc = "Goto implementation" })
    end
    if caps.typeDefinitionProvider then
        map("n", "gt", telescope.lsp_type_definitions, { desc = "Goto type definition" })
    end
    if caps.referencesProvider then
        map("n", "gr", telescope.lsp_references, { desc = "Goto references" })
    end

    -- Code actions
    if caps.documentFormattingProvider then
        map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format Document" })
    end
    if caps.documentRangeFormattingProvider then
        map("v", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format Document" })
    end
    if caps.renameProvider then
        map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
    end
    if caps.codeActionProvider then
        map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
    end
    if caps.codeLensProvider then
        map("n", "<leader>ll", vim.lsp.codelens.run, { desc = "CodeLens Action" })
    end

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
    map("n", "<leader>ld", function() telescope.diagnostics({ bufnr = 0 }) end, { desc = "Document Diagnostics" })
    map("n", "<leader>lwd", telescope.diagnostics, { desc = "Workspace Diagnostics" })

    -- Docs
    if caps.hoverProvider then
        map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover information" })
    end
    if caps.signatureHelpProvider then
        map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature_help" })
    end
    if caps.documentSymbolProvider then
        map("n", "<leader>ls", function() telescope.lsp_document_symbols({
                symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait",
                    "Variable" },
            })
        end, { desc = "Document Symbols" })
    end

    -- Workspaces
    if caps.workspace then
        map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add folder to workspace" })
        map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove folder from workspace" })
        map("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            { desc = "List workspace folders" })
    end
    if caps.workspaceSymbolProvider then
        map("n", "<leader>lws", function() telescope.lsp_dynamic_workspace_symbols({
                symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait",
                    "Variable" },
            })
        end, { desc = "Workspace Symbols" })
    end

    local wk_status_ok, which_key = pcall(require, "which-key")
    if not wk_status_ok then
        return
    end

    which_key.register({
        ["<leader>"] = {
            l = { name = "+LSP",
                w = "+Workspace"
            },
        }
    }, { mode = "n" })
end

function M.setup(client, bufnr)
    keymaps(client, bufnr)
end

return M
