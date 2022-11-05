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

    -- Autopairs --
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and Treesitter

    -- Buffers --
    use("akinsho/bufferline.nvim") -- Buffers as tabs
    use("moll/vim-bbye") -- Close buffers without closing windows

    -- Colorschemes & Color --
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        run = function()
            require("catppuccin").compile()
        end,
    }) -- Catpuccin color scheme
    use("norcalli/nvim-colorizer.lua") -- Colororizes color codes

    -- Comments --
    use("numToStr/Comment.nvim") -- Easily comment stuff
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Completion & Snippets plugins --
    -- Cmp
    use({ "hrsh7th/nvim-cmp",
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
    use("folke/neodev.nvim")
    -- Snippets
    use({ "L3MON4D3/LuaSnip", --snippet engine
        requires = { "saadparwaiz1/cmp_luasnip" }
    })
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- Github Copilot
    use({ "zbirenbaum/copilot.lua",
        disable = true,
        event = "VimEnter",
        config = function()
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.defer_fn(function()
                require("user.plugins.copilot")
                ---@diagnostic disable-next-line: param-type-mismatch
            end, 100)
        end,
    }, { "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    })

    -- Dashboard --
    use({ "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" }
    })

    -- Debugging --
    use({
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        "leoluz/nvim-dap-go"
    })
    use({ "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" }
    })
    use({ "theHamsta/nvim-dap-virtual-text",
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter"
        }
    })
    use("Pocco81/DAPInstall.nvim")

    -- File Explorer --
    use({ "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" }
    })

    -- Git --
    use({ "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })
    use("kdheepak/lazygit.nvim")

    -- Java --
    use("mfussenegger/nvim-jdtls")

    -- Keymaps --
    use("folke/which-key.nvim")

    -- Latex & Markdown Previews --
    use("frabjous/knap") -- allows livepreviewing of markdown and latex files
    use("ellisonleao/glow.nvim") -- preview markdown files in nvim
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" })

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

    use("tamago324/nlsp-settings.nvim") --language server settings defined in json for
    use("b0o/SchemaStore.nvim") -- JSON schemas
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- Show lsp errors inline
    use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
    use("j-hui/fidget.nvim") -- Show LSP progress

    -- Motions --
    use("kylechui/nvim-surround")

    -- Notifications --
    use("rcarriga/nvim-notify") -- Fancy notifications

    -- Projects --
    use("ahmedkhalf/project.nvim") -- Project management

    -- Statusline --
    use("nvim-lualine/lualine.nvim") -- Statusline

    -- Telescope --
    use({ "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
            "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
        },
        { "nvim-telescope/telescope-media-files.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    })

    -- Terminal --
    use("akinsho/toggleterm.nvim") -- Terminal

    -- Treesitter & Highlighting --
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use({ "p00f/nvim-ts-rainbow",
        requires = { "nvim-treesitter/nvim-treesitter" },
        after = { "nvim-treesitter" }
    })
    use({ "nvim-treesitter/playground",
        requires = { "nvim-treesitter/nvim-treesitter" },
        after = { "nvim-treesitter" }
    })
    -- Syntax highlighting
    use("fladson/vim-kitty") -- Enables syntax highlighting in kitty.conf
    use("lukas-reineke/indent-blankline.nvim") -- Indentation lines

    -- Pet duck --
    use({
        "tamton-aquib/duck.nvim",
        config = function()
            vim.keymap.set("n", "<leader>Dd", function() require("duck").hatch() end, { desc = "Hatch a duck" })
            vim.keymap.set("n", "<leader>Dk", function() require("duck").cook() end, { desc = "Cook a duck" })

            local wk_status_ok, wk = pcall(require, "which-key")
            if not wk_status_ok then
                return
            end

            wk.register({
                D = { name = "+Duck", },
            }, { prefix = "<leader>" })
        end
    })

    -- UI --
    use({ "stevearc/dressing.nvim" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
