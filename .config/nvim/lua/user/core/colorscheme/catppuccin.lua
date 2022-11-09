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
        harpoon = false,
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
        noice = false,
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
        ts_rainbow = false,
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
            colored_indent_levels = false,
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
    custom_highlights = function(colors)
        local virtual_text = cnf.integrations.native_lsp.virtual_text
        return { -- Personally the default integration is already pretty good
            NoiceCmdline = { fg = cp.text },
            NoiceCmdlineIcon = { fg = cp.sky, style = virtual_text.information },
            NoiceCmdlineIconSearch = { fg = cp.yellow },
            NoiceCmdlinePopup = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.base },
            NoiceCmdlinePopupBorder = { fg = cp.lavender },
            NoiceCmdlinePopupBorderSearch = { fg = cp.yellow },
            NoiceConfirm = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.base },
            NoiceConfirmBorder = { fg = cp.blue },
            NoiceCursor = { fg = cp.text },
            NoiceMini = { fg = cp.text },
            NoicePopup = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.mantle },
            NoicePopupBorder = { link = "FloatBorder" },
            NoicePopupmenu = { link = "Pmenu" },
            NoicePopupmenuBorder = { link = "FloatBorder" },
            NoicePopupmenuMatch = { link = "Special" },
            NoicePopupmenuSelected = { link = "PmenuSel" },
            NoiceScrollbar = { link = "PmenuSbar" },
            NoiceScrollbarThumb = { link = "PmenuThumb" },
            NoiceSplit = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.mantle },
            NoiceSplitBorder = { link = "FloatBorder" },
            NoiceVirtualText = { link = "DiagnosticVirtualTextInfo" },
        }
    end
})
