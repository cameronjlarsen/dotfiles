---@diagnostic disable: missing-parameter
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local deps_ok, cmp_dap, luasnip = pcall(function()
    return require("cmp_dap"), require("luasnip")
end)
if not deps_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()
local kind_icons = require("core.icons").lspkind

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    performance = {
        debounce = 60
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or cmp_dap.is_dap_buffer()
    end,
    mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local prsnt, lspkind = pcall(require, "lspkind")
            if not prsnt then
                -- Kind icons
                -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            else
                return lspkind.cmp_format({
                    mode = "symbol",
                    max_width = 50,
                    symbol_map = { Copilot = " " }
                })
            end
            vim_item.menu = ({
                nvim_lsp_signature_help = "[LSP SignatureHelp]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                buffer = "[Buffer]",
                rg = "[Rg]",
                path = "[Path]",
                latex_symbols = "[LaTeX]",
                emoji = "[Emoji]",
                dap = "[Dap]",
                copilot = "[Copilot]"
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources(
        {
            { name = "nvim_lsp", keyword_length = 1 },
            { name = "nvim_lsp_signature_help", keyword_length = 1 },
            { name = "nvim_lua" },
            { name = "luasnip" },
        },
        {
            { name = "copilot" },
            { name = "path" },
            { name = "buffer", keyword_length = 5 },
            { name = "rg", keyword_length = 5 },
        },
        {
            { name = "latex_symbols" },
            { name = "emoji" },
        }
    ),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
    },
    view = {
        entries = { name = "custom", selection_order = "near_cursor" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})
