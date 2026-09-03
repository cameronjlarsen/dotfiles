-- lua/plugins/rose-pine.lua
return {
    {
        "rose-pine/neovim",
        cond = not vim.g.vscode,
        name = "rose-pine",
        priority = 900,
        opts = function(_, opts)
            local cp = require("rose-pine.palette")
            local cnf = require("rose-pine.config").options
            opts.highlight_groups = {
                NoiceCmdlinePopupborder = { fg = cp.pine },
                -- Status Line --
                SLCopilot = { fg = cp.pine, bg = cnf.styles.transparency and cp.none or cp.base },
                SLGitIcon = { fg = cp.text, bg = cnf.styles.transparency and cp.none or cp.base },
                SLLSPIcon = { fg = cp.iris, bg = cnf.styles.transparency and cp.none or cp.base },

                -- Telescope
                TelescopeBorder = { bg = cp.base, fg = cp.base },
                TelescopeNormal = { bg = cp.base },
                TelescopePreviewBorder = { bg = cp.surface, fg = cp.surface },
                TelescopePreviewNormal = { bg = cp.surface },
                TelescopePreviewTitle = { bg = cp.surface, fg = cp.iris },
                TelescopePromptBorder = { bg = cp.overlay, fg = cp.overlay },
                TelescopePromptNormal = { bg = cp.overlay },
                TelescopePromptTitle = { bg = cp.overlay, fg = cp.pine },
                TelescopeSelection = { bg = cp.base, fg = cp.pine },
                TelescopeMultiSelection = { bg = cp.base, fg = cp.foam },
            }
        end

    },
    {
        'akinsho/bufferline.nvim',
        event = 'ColorScheme',
        opts = function(_, opts)
            if (vim.g.colors_name or ""):find("rose-pine") then
                local cp = require("rose-pine.palette")
                opts.highlights = require('rose-pine.plugins.bufferline')
                opts.highlights.indicator_selected = { fg = cp.iris }
            end
        end
    }
}
