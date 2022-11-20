local M = {}

M.highlight = true

function M.toggle()
	M.highlight = not M.highlight
	if M.highlight then
		vim.notify("LSP highlight enabled")
	else
		vim.notify("LSP highlight disabled")
	end
end

function M.highlight(client, bufnr)
	if M.highlight then
		if client.server_capabilities.documentHighlightProvider then
			local present, _ = pcall(require, "illuminate")
			if not present then
				local lsp_highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", {
					clear = false,
				})
				vim.api.nvim_clear_autocmds({
					buffer = bufnr,
					group = lsp_highlight_group,
				})
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = lsp_highlight_group,
					buffer = bufnr,
					callback = function()
						vim.schedule(vim.lsp.buf.document_highlight)
					end,
				})
				vim.api.nvim_create_autocmd("CursorMoved", {
					group = lsp_highlight_group,
					buffer = bufnr,
					callback = function()
						vim.schedule(vim.lsp.buf.clear_references)
					end,
				})
			end
		end
	end
end

function M.setup(client, bufnr)
	M.highlight(client, bufnr)
end

return M
