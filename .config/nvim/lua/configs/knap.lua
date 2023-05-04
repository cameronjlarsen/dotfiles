local status_ok, _ = pcall(require, "knap")
if not status_ok then
    return
end

local gknapsettings = {
    mdoutputext           = "pdf",
    mdtopdf               = "pandoc -s -f markdown -t pdf -F mermaid-filter %docroot% -o %outputfile%",
    mdtopdfviewerlaunch   = "sioyek %outputfile%",
    mdtopdfviewerrefresh  = "none",
    mdtopdfforwardjump    = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
    texoutputext          = "pdf",
    textopdf              = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdfviewerlaunch  = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --new-windoow %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump   = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%"
}

vim.g.knap_settings = gknapsettings
