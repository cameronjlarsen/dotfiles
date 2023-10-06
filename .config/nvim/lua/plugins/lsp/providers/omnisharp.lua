return {
    filetypes = { "cs", "vb", "razor", "cshtml" },
    enable_editorconfig_support = true,
    enalbe_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    settings = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
