return {
    "akinsho/toggleterm.nvim",
    cond = not vim.g.vscode,
    version = "*",
    keys = {
        { "<leader>tt", function() toggle_float() end,      desc = "Float Terminal" },
        { "<leader>tv", function() toggle_vertical() end,   desc = "Vertical Terminal" },
        { "<leader>th", function() toggle_horizontal() end, desc = "Horizontal Terminal" },
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = "<M-t>",
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        highlights = {
            FloatBorder = { link = "FloatBorder" },
        },
        float_opts = {
            border = "curved",
            winblend = 0,
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        vim.api.nvim_create_autocmd({ "TermOpen" }, {
            pattern = { "term://*" },
            callback = function()
                local function map(mode, lhs, rhs, options)
                    options = vim.tbl_extend("keep", options,
                        { silent = true })
                    vim.keymap.set(mode, lhs, rhs, options)
                end

                local options = { buffer = 0 }
                map('t', '<esc>', [[<C-\><C-n>]], options)
                map('t', 'jk', [[<C-\><C-n>]], options)
                map('t', '<C-h>', [[<C-\><C-n><C-W>h]], options)
                map('t', '<C-j>', [[<C-\><C-n><C-W>j]], options)
                map('t', '<C-k>', [[<C-\><C-n><C-W>k]], options)
                map('t', '<C-l>', [[<C-\><C-n><C-W>l]], options)
            end,
        })

        local Terminal = require("toggleterm.terminal").Terminal
        local vertical = Terminal:new({
            direction = "vertical",
            hidden = true,
        })

        function _G.toggle_vertical()
            vertical:toggle()
        end

        local horizontal = Terminal:new({
            direction = "horizontal",
            hidden = true,
        })

        function _G.toggle_horizontal()
            horizontal:toggle()
        end

        local float = Terminal:new({
            direction = "float",
            hidden = true,
        })

        function _G.toggle_float()
            float:toggle()
        end
    end,
}
