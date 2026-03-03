return {
	{
		"CoolCoderSuper/vbnet.nvim",
		config = function()
			require("vbnet").setup()
			vim.lsp.config["vb_ls"] = {
				cmd = { "vb-ls" },
				root_markers = { "*.sln", "*.vbproj" },
				filetypes = { "vbnet" },
				init_options = {
					AutomaticWorkspaceInit = true,
				},
			}

			vim.lsp.enable("vb_ls")
		end,
	},
}
