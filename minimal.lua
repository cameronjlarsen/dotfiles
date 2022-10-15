-- `minimal.lua` used for reproducible configuration
-- Open with `nvim --clean -u minimal.lua`

local is_windows = vim.fn.has("win32") == 1
local function join(...)
    local sep = is_windows and "\\" or "/"
    return table.concat({ ... }, sep)
end

local root_tmp = is_windows and os.getenv("TEMP") or "/tmp"
local site_path = join(root_tmp, "nvim", "site")
local pack_path = join(site_path, "pack")
local install_path = join(pack_path, "packer", "start", "packer.nvim")
local compile_path = join(install_path, "plugin", "packer_compiled.lua")
vim.opt.packpath = site_path

local function load_plugins()
    local packer = require("packer")
    local use = packer.use
    packer.reset()
    packer.init({ compile_path = compile_path, package_root = pack_path })

    use("wbthomason/packer.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    -- ADD PLUGINS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
    use({
        "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
    })

    packer.install()
end

_G.load_config = function()
    -- ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
    vim.g.catppuccin_flavour = "mocha"
    require("catppuccin").setup({
        transparent_background = false,
        integrations = {
            telescope = true,
        },
        custom_highlights = {
            WhichKeyGroup = { fg = "#FAB387" },
            WhichKeySeparator = { fg = "#cdd6f4" },
        },
    })

    local status_ok, treesitter = pcall(require, "nvim-treesitter")
    if not status_ok then
        return
    end

    local status_ok1, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok1 then
        return
    end

    configs.setup({
        ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
        -- ensure_installed = "all",
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "vim" }, -- List of parsers to ignore installing
        autopairs = {
            enable = true,
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "vim" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { "python", "css" } },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "markdown" },
        callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
        end,
    })

    vim.cmd("colorscheme catppuccin")
end

if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end
load_plugins()
vim.cmd([[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]])
