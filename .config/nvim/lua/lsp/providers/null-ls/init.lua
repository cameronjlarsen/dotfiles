local status_ok, null_ls, mason_null_ls = pcall(function()
    return require("null-ls"), require("mason-null-ls")
end)
if not status_ok then
    return
end

local function with_root_file(...)
    local files = { ... }
    return function(utils)
        return utils.root_has_file(files)
    end
end

local b = null_ls.builtins

mason_null_ls.setup({
    ensure_installed = {
        "stylua",
    },
})

-- Setup mason null-ls sources
mason_null_ls.setup_handlers({
    function(source_name, methods)
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    stylua = function()
        null_ls.register(b.formatting.stylua.with({
            condition = with_root_file({ "stylua.toml", ".stylua.toml" }),
        }))
    end,
    flake8 = function()
        null_ls.register(b.diagnostics.flake8)
    end,
    clang_format = function()
        null_ls.register(b.formatting.clang_format.with({
            disabled_filetypes = { "java", "cs" }
        }))
    end,
    cbfmt = function()
        null_ls.register(b.formatting.cbfmt.with({
            condition = with_root_file(".cbfmt.toml"),
        }))
    end,
    sql_formatter = function()
        null_ls.register(b.formatting.sql_formatter.with({
            extra_args = { "--language", "postgres" },
        }))
    end,
})
-- null_ls.setup()
null_ls.setup({
    on_attach = require("lsp.providers.defaults").on_attach,
    sources = {
        b.code_actions.gitsigns,
        b.formatting.google_java_format,
        b.formatting.latexindent,
        b.diagnostics.zsh,
        b.hover.dictionary,
        b.hover.printenv,
    },
})
