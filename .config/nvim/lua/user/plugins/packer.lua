local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
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
    require("packer").packadd = "packer.nvim"
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerSync",
    pattern = "packer.lua",
    group = group,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
        vim.notify_once("Compile Done", vim.log.levels.INFO)
    end,
    group = group,
})
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local icons = require("user.icons")
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

    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("lewis6991/impatient.nvim") -- Load plugins faster
    use("akinsho/bufferline.nvim") -- Buffers as tabs
    use("moll/vim-bbye") -- Close buffers without closing windows
    use("norcalli/nvim-colorizer.lua") -- Colororizes color codes
    use("numToStr/Comment.nvim") -- Easily comment stuff
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("stevearc/dressing.nvim") -- Improves vim ui input
    use("rcarriga/nvim-notify") -- Fancy notifications
    use("nvim-lualine/lualine.nvim") -- Statusline
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and Treesitter
    use("folke/which-key.nvim") -- Show keymaps
    use("folke/neodev.nvim") -- Neovim api completions
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
    use("kdheepak/lazygit.nvim") -- Lazygit nvim integration
    use("mfussenegger/nvim-jdtls")
    use("frabjous/knap") -- allows livepreviewing of markdown and latex files
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" })
    use("kylechui/nvim-surround") -- Surround text objects with characters
    use("ahmedkhalf/project.nvim") -- Project management
    use("akinsho/toggleterm.nvim") -- Terminal
    use("fladson/vim-kitty") -- Enables syntax highlighting in kitty.conf
    use("lukas-reineke/indent-blankline.nvim") -- Indentation lines
    use("tamago324/nlsp-settings.nvim") --language server settings defined in json for
    use("b0o/SchemaStore.nvim") -- JSON schemas
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- Show lsp errors inline
    use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
    use("j-hui/fidget.nvim") -- Show LSP progress

    use({
        "narutoxy/silicon.lua",
        requires = { "nvim-lua/plenary.nvim" },
    }) -- Screenshots with silicon
    use({
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" }
    }) -- Dashboard
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" }
    })
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        run = function()
            require("catppuccin").compile()
        end,
    }) -- Catpuccin color scheme
    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }) -- Improved cmdline, messages, popupmenu UI

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "rcarriga/cmp-dap",
            "kdheepak/cmp-latex-symbols",
            "lukas-reineke/cmp-rg"
        }
    })
    use({
        "L3MON4D3/LuaSnip", --snippet engine
        requires = { "saadparwaiz1/cmp_luasnip" }
    })
    use({
        "zbirenbaum/copilot.lua",
        opt = true,
        config = function()
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.defer_fn(function()
                require("user.plugins.copilot")
                ---@diagnostic disable-next-line: param-type-mismatch
            end, 100)
        end,
        {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
                require("copilot_cmp").setup()
            end
        },
    })

    -- Debugging --
    use({
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        "leoluz/nvim-dap-go"
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" }
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter"
        }
    })

    -- LSP --
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        { "jose-elias-alvarez/null-ls.nvim",
            requires = { "nvim-lua/plenary.nvim" }
        },
        "jayp0521/mason-null-ls.nvim",
    }

    -- Telescope --
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
            "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
        },
        { "nvim-telescope/telescope-media-files.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    })
    -- Treesitter & Highlighting --
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        { "p00f/nvim-ts-rainbow",
            requires = { "nvim-treesitter/nvim-treesitter" },
            after = { "nvim-treesitter" }
        },
        { "nvim-treesitter/playground",
            requires = { "nvim-treesitter/nvim-treesitter" },
            after = { "nvim-treesitter" }
        }
    })

    use({
        "tamton-aquib/duck.nvim",
        config = function()
            require("user.plugins.duck").setup()
        end
    }) -- Show a pet duck on the screen

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
