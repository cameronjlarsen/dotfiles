local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

catppuccin.setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        aerial = false,
        barbar = false,
        beacon = false,
        cmp = true,
        coc_nvim = false,
        dashboard = true,
        fern = false,
        fidget = true,
        gitgutter = false,
        gitsigns = true,
        harpoon = true,
        hop = false,
        illuminate = false,
        leap = false,
        lightspeed = false,
        lsp_saga = false,
        lsp_trouble = false,
        markdown = true,
        mason = true,
        mini = false,
        neogit = false,
        neotest = false,
        neotree = false,
        noice = true,
        notify = true,
        nvimtree = true,
        overseer = false,
        pounce = false,
        semantic_tokens = false,
        symbols_outline = false,
        telekasten = false,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = true,
        vim_sneak = false,
        vimwiki = false,
        which_key = true,

        -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
        dap = {
            enabled = true,
            enable_ui = true,
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        navic = {
            enabled = false,
            custom_bg = "NONE",
        },
    },
    custom_highlights = function(cp)
        local cnf = catppuccin.options
        return {
            ["SLCopilot"] = { fg = cp.green, bg = cnf.transparent_background and cp.none or cp.mantle },
            ["SLGitIcon"] = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.mantle },
            ["SLLSPIcon"] = { fg = cp.blue, bg = cnf.transparent_background and cp.none or cp.mantle },
            ["LSPInlayHint"] = { fg = cp.surface2, bg = cnf.transparent_background and cp.none or cp.mantle,
                style = { "italic" } },
            ["FloatBorder"] = { fg = cp.blue, bg = cnf.transparent_background and cp.none or cp.mantle },

            -- Telescope
            TelescopeBorder = { bg = cp.crust, fg = cp.crust },
            TelescopeNormal = { bg = cp.crust },

            -- Telescope Preview
            TelescopePreviewBorder = { bg = cp.mantle, fg = cp.mantle },
            TelescopePreviewNormal = { bg = cp.mantle },
            TelescopePreviewTitle = { bg = cp.mantle, fg = cp.lavender },

            -- Telescope Prompt
            TelescopePromptBorder = { bg = cp.surface0, fg = cp.surface0 },
            TelescopePromptNormal = { bg = cp.surface0 },
            TelescopePromptTitle = { bg = cp.surface0, fg = cp.green },
            -- TelescopePromptPrefix = { bg = cp.surface0, fg = cp.red },

            -- Telescope Selection
            TelescopeSelection = { bg = cp.crust, fg = cp.green },
            TelescopeMultiSelection = { bg = cp.crust, fg = cp.blue },
        }
    end,
})
