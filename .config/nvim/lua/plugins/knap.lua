return {
    {
        "folke/which-key.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>n"] = { name = "+Knap" },
            },
        },
    },
    {
        "frabjous/knap",
        cond = not vim.g.vscode,
        ft = { "markdown", "tex" },
        keys = {
            { "<leader>np", function() require("knap").process_once() end,          desc = "Preview" },
            { "<leader>nc", function() require("knap").close_viewer() end,          desc = "Close Preview" },
            { "<leader>nt", function() require("knap").toggle_autopreviewing() end, desc = "Toggle Auto-Preview" },
            { "<leader>nj", function() require("knap").forward_jump() end,          desc = "Forward jump" },
        },
        init = function()
            vim.g.knap_settings = {
                mdoutputext          = "pdf",
                mdtopdf              = "pandoc -s --highlight-style tango -f markdown -t pdf -F mermaid-filter %docroot% -o %outputfile%",
                mdtopdfviewerlaunch  = "sioyek %outputfile%",
                mdtopdfviewerrefresh = "none",
                -- texoutputext          = "pdf",
                -- textopdf              = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
                -- textopdfviewerlaunch  =
                -- "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --new-windoow %outputfile%",
                -- textopdfviewerrefresh = "none",
                -- textopdfforwardjump   =
                -- "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%"
            }
        end
    }
}
