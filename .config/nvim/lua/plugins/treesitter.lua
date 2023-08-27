return {
    {
        "nvim-treesitter/nvim-treesitter", -- Nvim Treesitter configurations and abstraction layer.
        version = false,
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/playground",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
        opts = {
            ensure_installed = "all",
            sync_install = false,
            ignore_install = { "" }, -- List of parsers to ignore installing
            autopairs = {
                enable = true,
            },
            highlight = {
                enable = true,         -- false will disable the whole extension
                disable = { "latex" }, -- list of language that will be disabled
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, disable = { "yaml" } },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                        ["ir"] = "@parameter.inner",
                        ["ar"] = "@parameter.outer",
                    },
                },
            },
            rainbow = {
                enable = true,
                extended_mode = true,  -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                max_file_lines = 2000, -- Do not enable for files with more than specified lines
            },
            autotag = {
                enable = true,
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                --@type table<string, boolean>
                local added = {}
                opts.ensure_installedg = vim.tbl_filter(function(lang)
                    if not added[lang] then
                        added[lang] = true
                        return true
                    end
                    return false
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {}
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = { { "J", function() require("treesj").toggle() end, desc = "Join toggle" } },
        opts = {
            use_default_keymaps = false,
            max_join_length = 150,
        },
    }
}
