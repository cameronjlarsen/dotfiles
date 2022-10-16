local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

vim.g.catppuccin_flavour = "mocha"

catppuccin.setup({
    integrations = {
        transparent_background = false,
        cmp                    = true,
        fidget                 = true,
        notify                 = true,
        telescope              = true,
        treesitter_context     = true,
        treesitter             = true,
        which_key              = true,
        dap                    = {
            enabled   = true,
            enable_ui = true,
        },
        indent_blankline       = {
            enabled               = true,
            colored_indent_levels = false,
        },
        native_lsp             = {
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
        bufferline             = true,
    }
})
