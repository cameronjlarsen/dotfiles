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
            "nvim-treesitter/playground",
            "windwp/nvim-ts-autotag",
        },
        opts = {
            install = {
                prefer_git = false,
                compilers = { "zig" },
            },
            ensure_installed = {
                "lua", "c", "cpp", "python", "bash",
                "javascript", "typescript", "html", "css", "json",
                "yaml", "toml", "rust", "java", "c_sharp",
                "gitcommit", "gitignore", "gitattributes", "git_config", "git_rebase"
            },
            sync_install = false,
            ignore_install = { "" }, -- List of parsers to ignore installing
            autopairs = {
                enable = true,
            },
            autotag = {
                enable = not vim.g.vscode
            },
            highlight = {
                enable = not vim.g.vscode, -- false will disable the whole extension
                disable = { "latex" },     -- list of language that will be disabled
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true, disable = { "yaml" } },
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
                move = {
                    enable = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                }
            },
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { "BufWrite", "CursorHold" },
            },
            playground = {
                enable = not vim.g.vscode
            },
            matchup = {
                enable = not vim.g.vscode
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                --@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if not added[lang] then
                        added[lang] = true
                        return true
                    end
                    return false
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.install").prefer_git = false
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
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            -- Disable class keymaps in diff mode
            vim.api.nvim_create_autocmd("BufReadPost", {
                callback = function(event)
                    if vim.wo.diff then
                        for _, key in ipairs({ "[c", "]c", "[C", "]C" }) do
                            pcall(vim.keymap.del, "n", key, { buffer = event.buf })
                        end
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        cond = not vim.g.vscode,
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
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        }
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
          -- Must use init (not config) so vim.g.rainbow_delimiters is set
          -- BEFORE plugin/rainbow-delimiters.lua sources and registers the
          -- FileType * autocommand. config runs after, causing a race where
          -- noice/nui/cmp popup buffers trigger FileType before condition is set.
          vim.g.rainbow_delimiters = {
            condition = function(bufnr)
              local buftype = vim.bo[bufnr].buftype
              -- Skip all non-file buffers: noice popups, nui splits, cmp docs, etc.
              if buftype ~= "" then return false end
              local ft = vim.bo[bufnr].filetype
              if ft == "" then return false end
              local lang = vim.treesitter.language.get_lang(ft)
              if not lang then return false end
              local ok = pcall(vim.treesitter.get_parser, bufnr, lang)
              return ok
            end,
          }
        end,
    },
}
