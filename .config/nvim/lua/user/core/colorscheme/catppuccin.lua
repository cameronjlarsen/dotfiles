local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

catppuccin.setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        cmp                = true,
        fidget             = true,
        notify             = true,
        telescope          = true,
        treesitter_context = true,
        treesitter         = true,
        which_key          = true,
        mason              = true,
        dap                = {
            enabled   = true,
            enable_ui = true,
        },
        indent_blankline   = {
            enabled               = true,
            colored_indent_levels = false,
        },
        native_lsp         = {
            enabled      = true,
            virtual_text = {
                errors      = { "italic" },
                hints       = { "italic" },
                warnings    = { "italic" },
                information = { "italic" },
            },
            underlines   = {
                errors      = { "underline" },
                hints       = { "underline" },
                warnings    = { "underline" },
                information = { "underline" },
            },
        },
        nvimtree           = {
            enabled = true,
            show_root = true,
            transparent_panel = true,
        },
        bufferline         = true,
    }
})
