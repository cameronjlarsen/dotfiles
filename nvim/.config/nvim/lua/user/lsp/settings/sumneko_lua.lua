return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
                    "vim",
                    "awesome",
                    "client",
                    "root",
                    "screen"
                },
			},
			completion = {
				keywordSnippet = "Replace",
				callSnippet = "Replace",
			},
			workspace = {
				library = {
                    vim.api.nvim_get_runtime_file("", true),
                    "/usr/share/awesome/lib/",
                },
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
