local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

local cp = require("catppuccin.palettes").get_palette()
bufferline.setup {
    options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = "▌",
            style = "icon"
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, _, context)
            if context.buffer:current() then
                return ""
            end
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
        },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    highlights = require("catppuccin.groups.integrations.bufferline").get({
        custom = {
            all = {
                -- fill = { bg = cp.crust },
                buffer_selected = { bg = cp.mantle },
                separator_selected = { bg = cp.mantle },
                close_button_selected = { bg = cp.mantle },
            }
        }

    })
}
