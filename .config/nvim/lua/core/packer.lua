local function ensure_packer()
    local fn = vim.fn
    -- Automatically install packer
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    ---@diagnostic disable-next-line: missing-parameter
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        print("Installing packer close and reopen Neovim...")
        require("packer").packadd = "packer.nvim"
    end
end

local packer_bootstrap = ensure_packer()
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local icons = require("core.icons")
-- Have packer use a popup window
packer.init({
    display = {
        working_sym = icons.ui.PackagePending,
        error_sym = icons.ui.PackageError,
        done_sym = icons.ui.PackageInstalled,
        removed_sym = icons.ui.PackageUninstalled,
        moved_sym = icons.ui.PackageMoved,
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    auto_reload_compiled = true,
})

-- Install your plugins here
return packer.startup(function(use)

    use("wbthomason/packer.nvim") -- Have packer manage itself.
    use("lewis6991/impatient.nvim") -- Improve startup time for Neovim

    -- Libraries --
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim.
    use("nvim-lua/plenary.nvim") -- All the lua functions I don't want to write twice.
    use({ "nvim-tree/nvim-web-devicons", config = require("configs.devicons") }) -- Adds filetype icons for plugins.

    -- Editor --
    use("akinsho/bufferline.nvim") -- A snazzy bufferline for Neovim.
    use("nvim-lualine/lualine.nvim") -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    use("numToStr/Comment.nvim") -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more.
    use("JoosepAlviste/nvim-ts-context-commentstring") -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
    use("windwp/nvim-autopairs") -- A super powerful autopair plugin for Neovim that supports multiple characters.
    use("nvim-tree/nvim-tree.lua") -- A file explorer tree for neovim written in lua.
    use("kylechui/nvim-surround") -- Add/change/delete surrounding delimiter pairs with ease.
    use("gpanders/editorconfig.nvim") -- EditorConfig plugin for Neovim

    -- Git --
    use("kdheepak/lazygit.nvim") -- Plugin for calling lazygit from within neovim.
    use("lewis6991/gitsigns.nvim") -- Git integration for buffers.
    use("sindrets/diffview.nvim") -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.


    -- Colorschemes --
    use({ -- Soothing pastel theme for Neovim.
        "catppuccin/nvim",
        as = "catppuccin",
        run = function()
            require("catppuccin").compile()
        end,
    })

    -- Completion --
    use("hrsh7th/nvim-cmp") -- A completion plugin for neovim coded in Lua.
    use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words.
    use("hrsh7th/cmp-path") -- nvim-cmp source for path.
    use("hrsh7th/cmp-cmdline") -- nvim-cmp source for vim's commandline.
    use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim builtin LSP client.
    use("hrsh7th/cmp-emoji") -- nvim-cmp source for emoji.
    use("hrsh7th/cmp-nvim-lua") -- nvim-cmp source for nvim lua.
    use("rcarriga/cmp-dap") -- nvim-cmp source for nvim-dap REPL and nvim-dap-ui buffers.
    use("kdheepak/cmp-latex-symbols") -- Add latex symbol support for nvim-cmp.
    use("lukas-reineke/cmp-rg") -- nvim-cmp source for ripgrep.
    use("saadparwaiz1/cmp_luasnip") -- luasnip completion source for nvim-cmp.
    use("rafamadriz/friendly-snippets") -- Set of preconfigured snippets for different languages.
    use("L3MON4D3/LuaSnip") -- Snippet Engine for Neovim written in Lua.
    use("folke/neodev.nvim") --Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    use("zbirenbaum/copilot.lua") -- Lua plugin for starting and interacting with github copilot
    use("zbirenbaum/copilot-cmp") -- Lua plugin to turn github copilot into a cmp source.

    -- Debugging --
    use("mfussenegger/nvim-dap") -- Debug Adapter Protocol client implementation for Neovim.
    use("rcarriga/nvim-dap-ui") -- A UI for nvim-dap.
    use("theHamsta/nvim-dap-virtual-text") -- Adds virtual text support to nvim-dap.
    use("mfussenegger/nvim-dap-python") -- n extension for nvim-dap, providing default configurations for python and methods to debug individual test methods or classes.
    use("leoluz/nvim-dap-go") -- An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests.

    -- LSP --
    use("williamboman/mason.nvim") -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
    use("williamboman/mason-lspconfig.nvim") -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    use("neovim/nvim-lspconfig") -- Quickstart configs for Nvim LSP.
    use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    use("jayp0521/mason-null-ls.nvim") -- Extension to Mason and null-ls that can automatically install the required tools for null-ls sources to work via Mason.
    use("b0o/SchemaStore.nvim") -- JSON schemas for Neovim.
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- Simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
    use("lvimuser/lsp-inlayhints.nvim") -- Partial implementation of LSP inlay hint

    -- Language Support
    use("mfussenegger/nvim-jdtls") -- Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls.

    -- Files/Search --
    use("nvim-telescope/telescope.nvim") -- Find, Filter, Preview, Pick. All lua, all the time.
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- FZF sorter for telescope written in C.
    use("nvim-telescope/telescope-media-files.nvim") -- Extension to preview media files using Ueberzug.
    use("nvim-telescope/telescope-symbols.nvim") -- Picking symbols and insert them at point.
    use("nvim-telescope/telescope-ui-select.nvim") -- Sets vim.ui.select to Telescope.
    use("nvim-telescope/telescope-file-browser.nvim") -- A file browser extension supporting synchronized creation, deletion, renaming, and moving of files and folders.

    -- Syntax & Highlighting --
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Nvim Treesitter configurations and abstraction layer.
    use("nvim-treesitter/nvim-treesitter-textobjects") -- Nvim Treesitter textobjects.
    use("p00f/nvim-ts-rainbow") -- Rainbow parentheses for neovim using tree-sitter.
    use("nvim-treesitter/playground") -- Treesitter playground integrated into Neovim.
    use("norcalli/nvim-colorizer.lua") -- A high-performance color highlighter for Neovim.

    -- UI --
    use("stevearc/dressing.nvim") -- Neovim plugin to improve the default vim.ui interfaces.
    use("rcarriga/nvim-notify") -- A fancy, configurable, notification manager for NeoVim.
    use("MunifTanjim/nui.nvim") -- UI Component Library for Neovim.
    use("folke/noice.nvim") -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
    use("folke/which-key.nvim") -- Lua plugin that displays a popup with possible keybindings of the command you started typing.
    use("lukas-reineke/indent-blankline.nvim") -- Indent guides for Neovim.
    use("goolord/alpha-nvim") -- A fast and fully programmable greeter for neovim.
    use("j-hui/fidget.nvim") -- Standalone UI for nvim-lsp progress.

    -- Utilities --
    use("moll/vim-bbye") -- Close buffers without closing windows
    use("frabjous/knap") -- Neovim plugin for creating live-updating-as-you-type previews of LaTeX, markdown, and other files in the viewer of your choice.
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" }) -- Markdown preview plugin for (neo)vim.
    use("ahmedkhalf/project.nvim") -- The superior project management solution for neovim.
    use("akinsho/toggleterm.nvim") -- A neovim lua plugin to help easily manage multiple terminal windows.
    use("narutoxy/silicon.lua") -- Beautiful code snippet images right in the most epic editor.
    use("tamton-aquib/duck.nvim") -- A duck that waddles arbitrarily in neovim.
    use("ThePrimeagen/harpoon") -- Per project, auto updating and editable marks utility for fast file navigation.
    use("mbbill/undotree") -- The ultimate undo history visualizer for vim.

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
