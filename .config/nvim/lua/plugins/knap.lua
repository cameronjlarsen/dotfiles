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
    textopdfviewerlaunch  = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump   = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
}

vim.g.knap_settings = gknapsettings
