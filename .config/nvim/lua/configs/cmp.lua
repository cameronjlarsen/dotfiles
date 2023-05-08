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
local icons = {
    kind = require("core.icons").get("kind"),
}

vim.api.nvim_create_autocmd('CursorMovedI', {
    pattern = '*',
    callback = function(ev)
        if not luasnip.session
            or not luasnip.session.current_nodes[ev.buf]
            or luasnip.session.jump_active
        then
            return
        end

        local current_node = luasnip.session.current_nodes[ev.buf]
        local current_start, current_end = current_node:get_buf_position()
        current_start[1] = current_start[1] + 1 -- (1, 0) indexed
        current_end[1] = current_end[1] + 1     -- (1, 0) indexed
        local cursor = vim.api.nvim_win_get_cursor(0)

        if cursor[1] < current_start[1]
            or cursor[1] > current_end[1]
            or cursor[2] < current_start[2]
            or cursor[2] > current_end[2]
        then
            luasnip.unlink_current()
        end
    end
})

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
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
        }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, and selections are visible, close cmp, else fallback.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                })
            elseif cmp.visible() then
                cmp.close()
            else
                fallback()
            end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                fallback()
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
                vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            else
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    max_width = 50,
                    symbol_map = { Copilot = icons.kind.Copilot }
                })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. strings[1] .. " "
                kind.menu = "    (" .. strings[2] .. ")"

                return kind
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
            { name = "copilot" },
            { name = "nvim_lsp",                keyword_length = 1 },
            { name = "nvim_lsp_signature_help", keyword_length = 1 },
            { name = "nvim_lua" },
            { name = "luasnip" },
        },
        {
            { name = "path" },
            { name = "buffer", keyword_length = 5 },
            { name = "rg",     keyword_length = 5 },
        },
        {
            { name = "latex_symbols" },
            { name = "emoji" },
        }
    ),
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:Search",
            col_offset = -3,
            side_padding = 0,
        },
        documentation = {
            winhighlight = "Normal:Normal,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
        },
    },
    experimental = {
        ghost_text = { hl_group = "Comment" },
    },
    view = {
        entries = { name = "custom", selection_order = "near_cursor" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
        { name = "nvim_lua" },
    }),
})

cmp.setup.cmdline({ "/", "?" }, {
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
