---@diagnostic disable: param-type-mismatch
local status, jdtls = pcall(require, "jdtls")
if not status then
    return
end

local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "linux"
else
    print("Unsupported system")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local bundles = {}
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar", 1), "\n"))
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
        ,
        "\n"
    )
)

local function java_keymaps()
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("keep", opts, { silent = true, buffer = true })
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "<leader>jo", function() jdtls.organize_imports() end, { desc = "Organize Imports" })
    map({ "n", "v" }, "<leader>je", function() jdtls.extract_variable() end, { desc = "Extract Variable" })
    map({ "n", "v" }, "<leader>jc", function() jdtls.extract_variable() end, { desc = "Extract Constant" })
    map("v", "<leader>jm", function() jdtls.extract_method() end, { desc = "Extract Method" })
    map("n", "<leader>df", function() jdtls.test_class() end, { desc = "Test Java Class" })
    map("n", "<leader>dn", function() jdtls.test_nearest_method() end, { desc = "Test Nearest Java Method" })

    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
        print("which-key not loaded")
        return
    end

    wk.register({
        ["<leader>"] = {
            j = { name = "+Java" },
        },
    })
end

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. mason_path .. "packages/jdtls/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(mason_path .. "packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        mason_path .. "packages/jdtls/config_" .. CONFIG,

        "-data",
        workspace_dir,
    },
    on_attach = function(client, bufnr)
        require("user.lsp.handlers").on_attach(client, bufnr)
        require("jdtls.dap").setup_dap_main_class_configs()
        jdtls.setup_dap()
        jdtls.setup.add_commands()
        java_keymaps()
    end,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                    {
                        name = "JavaSE-19",
                        path = "/usr/lib/jvm/java-19-openjdk/",
                    },
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = false,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },

    init_options = {
        bundles = bundles,
        extendedClientCapabilities = {
            progressReportProvider = true,
            classFileContentsSupport = true,
            generateToStringPromptSupport = true,
            hashCodeEqualsPromptSupport = true,
            advancedExtractRefactoringSupport = true,
            advancedOrganizeImportsSupport = true,
            generateConstructorsPromptSupport = true,
            generateDelegateMethodsPromptSupport = true,
            moveRefactoringSupport = true,
            overrideMethodsPromptSupport = true,
            inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
        },
    },
}

return config
