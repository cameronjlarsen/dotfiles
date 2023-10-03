return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "mocha",
            background = { light = "latte", dark = "mocha" },
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = true,
            styles = {
                comments = { "italic" },
                properties = { "italic" },
                functions = { "bold" },
                keywords = { "italic" },
                operators = { "bold" },
                conditionals = { "bold" },
                loops = { "bold" },
                booleans = { "bold", "italic" },
                numbers = {},
                types = {},
                strings = {},
                variables = {},
            },
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
                semantic_tokens = true,
                symbols_outline = false,
                telekasten = false,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                rainbow_delimiters = true,
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
                    scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
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
                local cnf = require("catppuccin").options
                return {
                    -- For base configs
                    NormalFloat = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.mantle },
                    FloatBorder = {
                        fg = cnf.transparent_background and cp.blue or cp.mantle,
                        bg = cnf.transparent_background and cp.none or cp.mantle,
                    },
                    CursorLineNr = { fg = cp.green },

                    -- For native lsp configs
                    LspInfoBorder = { link = "FloatBorder" },

                    -- For mason.nvim
                    MasonNormal = { link = "NormalFloat" },

                    -- For nvim-cmp and wilder.nvim
                    Pmenu = { bg = cp.surface0, fg = cp.text },
                    PmenuSel = { bg = cp.overlay0, fg = cp.text },
                    CmpItemKindSnippet = { fg = cp.base, bg = cp.mauve },
                    CmpItemKindKeyword = { fg = cp.base, bg = cp.red },
                    CmpItemKindText = { fg = cp.base, bg = cp.teal },
                    CmpItemKindMethod = { fg = cp.base, bg = cp.blue },
                    CmpItemKindConstructor = { fg = cp.base, bg = cp.blue },
                    CmpItemKindFunction = { fg = cp.base, bg = cp.blue },
                    CmpItemKindFolder = { fg = cp.base, bg = cp.blue },
                    CmpItemKindModule = { fg = cp.base, bg = cp.blue },
                    CmpItemKindConstant = { fg = cp.base, bg = cp.peach },
                    CmpItemKindField = { fg = cp.base, bg = cp.green },
                    CmpItemKindProperty = { fg = cp.base, bg = cp.green },
                    CmpItemKindEnum = { fg = cp.base, bg = cp.green },
                    CmpItemKindUnit = { fg = cp.base, bg = cp.green },
                    CmpItemKindClass = { fg = cp.base, bg = cp.yellow },
                    CmpItemKindVariable = { fg = cp.base, bg = cp.flamingo },
                    CmpItemKindFile = { fg = cp.base, bg = cp.blue },
                    CmpItemKindInterface = { fg = cp.base, bg = cp.yellow },
                    CmpItemKindColor = { fg = cp.base, bg = cp.red },
                    CmpItemKindReference = { fg = cp.base, bg = cp.red },
                    CmpItemKindEnumMember = { fg = cp.base, bg = cp.red },
                    CmpItemKindStruct = { fg = cp.base, bg = cp.blue },
                    CmpItemKindValue = { fg = cp.base, bg = cp.peach },
                    CmpItemKindEvent = { fg = cp.base, bg = cp.blue },
                    CmpItemKindOperator = { fg = cp.base, bg = cp.blue },
                    CmpItemKindTypeParameter = { fg = cp.base, bg = cp.blue },
                    CmpItemKindCopilot = { fg = cp.base, bg = cp.teal },

                    -- For fidget.nvim
                    FidgetTask = { fg = cp.surface2, bg = cp.none },
                    FidgetTitle = { fg = cp.blue, style = { "bold" } },

                    -- Status Line --
                    SLCopilot = { fg = cp.green, bg = cnf.transparent_background and cp.none or cp.mantle },
                    SLGitIcon = { fg = cp.text, bg = cnf.transparent_background and cp.none or cp.mantle },
                    SLLSPIcon = { fg = cp.blue, bg = cnf.transparent_background and cp.none or cp.mantle },

                    -- For tabline selected tab
                    TabLineSel = { fg = cp.lavender, bg = cp.lavender },

                    -- Telescope
                    TelescopeBorder = { bg = cp.crust, fg = cp.crust },
                    TelescopeNormal = { bg = cp.crust },
                    TelescopePreviewBorder = { bg = cp.mantle, fg = cp.mantle },
                    TelescopePreviewNormal = { bg = cp.mantle },
                    TelescopePreviewTitle = { bg = cp.mantle, fg = cp.lavender },
                    TelescopePromptBorder = { bg = cp.surface0, fg = cp.surface0 },
                    TelescopePromptNormal = { bg = cp.surface0 },
                    TelescopePromptTitle = { bg = cp.surface0, fg = cp.green },
                    TelescopeSelection = { bg = cp.crust, fg = cp.green },
                    TelescopeMultiSelection = { bg = cp.crust, fg = cp.blue },

                    -- For treesitter
                    ["@keyword.return"] = { fg = cp.pink, style = {} },

                    -- VimTeX --
                    texArg = { link = "@include" },
                    texFileArg = { link = "texArg" },
                    texCmd = { fg = cp.mauve, style = { "italic" } },
                    texCmdItem = { link = "@method" },
                    texCmdEnv = { fg = cp.lavender, style = { "italic" } },
                    texCmdDef = { link = "Typedef" },
                    texDefArgName = { link = "Type" },
                    texOpt = { link = "@parameter" },
                    texFileOpt = { fg = cp.maroon, style = { "italic" } },
                    texOptEqual = { link = "@keyword.operator" },
                    texDelim = { fg = cp.blue },
                    texLength = { fg = cp.text },
                    texEnvArgName = { link = "texArg" },
                    texMathZoneV = { link = "texMathZoneLI" },
                    texMathZoneW = { link = "texMathZoneLD" },
                    texMathZoneX = { link = "texMathZoneTI" },
                    texMathZoneY = { link = "texMathZoneTD" },
                    texMathZoneG = { link = "texMathZoneEnv" },
                    texMathZoneGS = { link = "texMathZoneEnvStarred" },
                    texMathZoneZ = { link = "texMathZoneEnsured" },
                    texStatement = { link = "texCmd" },
                }
            end,
        }

    },
    {
        "akinsho/bufferline.nvim", -- A snazzy bufferline for Neovim.
        opts = function(_, opts)
            local cp = require("catppuccin.palettes").get_palette()

            opts.highlights = require("catppuccin.groups.integrations.bufferline").get({
                custom = {
                    all = {
                        indicator_selected = { fg = cp.lavender },
                    }
                }
            })
        end,
    },
    {
        "narutoxy/silicon.lua", -- Beautiful code snippet images right in the most epic editor.
        opts = function(_, opts)
            local cp = require("catppuccin.palettes").get_palette()
            opts.theme = "Catppuccin-mocha"
            opts.bgColor = cp.lavender
        end,
    }
}
