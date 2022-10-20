local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

mason_null_ls.setup({
    ensure_installed = { "stylua" },
})

mason_null_ls.setup_handlers({
    function(source_name) end,
    stylua = function()
        null_ls.register(formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
        }))
    end,
    flake8 = function ()
        null_ls.register(diagnostics.flake8)
    end
})

-- null_ls.setup()
null_ls.setup({
    sources = {
        code_actions.gitsigns,
    },
})
