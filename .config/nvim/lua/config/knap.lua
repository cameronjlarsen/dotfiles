local status_ok, _ = pcall(require, "knap")
if not status_ok then
    return
end

local gknapsettings = {
    mdoutputext           = "pdf",
    mdtopdf               = "pandoc %docroot% -o %outputfile%",
    mdtopdfviewerlaunch   = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    mdtopdfviewerrefresh  = "none",
    mdtopdfforwardjump    = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
    texoutputext          = "pdf",
    textopdf              = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    -- Zathura config
    textopdfviewerlaunch  = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump   = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
    -- zathura config
    -- textopdfviewerlaunch = "zathura --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-instance %outputfile%",
    -- textopdfviewerrefresh = "none",
    -- textopdfforwardjump = "zathura --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-instance --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",   -- textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%"
}

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("keep", opts,
        { silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Processes the document once, and refreshes the view
map({ "n", "v" }, "<leader>kp", function()
    require("knap").process_once()
end,
    { desc = "Preview Once" })

-- Closes the viewer application, and allows settings to be reset
map({ "n", "v" }, "<leader>kc", function()
    require("knap").close_viewer()
end,
    { desc = "Close Viewer" })

-- Toggles the auto-processing on and off
map({ "n", "v" }, "<leader>kt", function()
    require("knap").toggle_autopreviewing()
end,
    { desc = "Toggle Auto-Preview" })

-- Invokes a SyncTeX forward search, or similar, where appropriate
map({ "n", "v" }, "<leader>kj", function()
    require("knap").forward_jump()
end,
    { desc = "SyncTex jump" })

vim.g.knap_settings = gknapsettings
