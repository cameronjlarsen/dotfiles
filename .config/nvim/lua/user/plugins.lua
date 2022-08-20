local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync",
	pattern = "plugins.lua",
	group = group,
})
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("fladson/vim-kitty") -- Enables syntax highlighting in kitty.conf
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and Treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("rcarriga/nvim-notify")
	use("norcalli/nvim-colorizer.lua") -- Colororizes color codes
    use("j-hui/fidget.nvim")

	-- Colorschemes
	use({
		"catppuccin/nvim",
		as = "catppuccin",
        run = ":CatpuccinCompile"
	}) -- Catpuccin color scheme

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lua")
	use("rcarriga/cmp-dap")
	use("kdheepak/cmp-latex-symbols")
	use("lukas-reineke/cmp-rg")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
    use("williamboman/mason.nvim") -- New lsp installer, succeeds nvim-lsp-installer
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig") --enable LSP
	use("tamago324/nlsp-settings.nvim") --language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("b0o/SchemaStore.nvim")
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim") -- Allows media files preview
	use("nvim-telescope/telescope-symbols.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	-- Comments
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("Pocco81/DAPInstall.nvim")

	-- Latex
	use("frabjous/knap") -- allows livepreviewing of markdown and latex files

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
