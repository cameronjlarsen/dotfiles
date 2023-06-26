return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>S"] = { name = "+Silicon" },
            },
        },
    },
    {
        "narutoxy/silicon.lua", -- Beautiful code snippet images right in the most epic editor.
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            {
                mode = { "n", "v" },
                "<leader>Sl",
                function() require("silicon").visualise_api({ debug = true }) end,
                desc = "Screenshot Line(s)"
            },
            {
                mode = { "n", "v" },
                "<leader>Sb",
                function() require("silicon").visualise_api({ debug = true, show_buf = true }) end,
                desc = "Screenshot Line(s) with Buffer",
            },
            {
                mode = { "n", "v" },
                "<leader>Sy",
                function() require("silicon").visualise_api({ debug = true, to_clip = true }) end,
                desc = "Screenshot Line(s) to Buffer",
            },
        },

        opts = {
            theme = "auto",
            output = vim.fn.expand("$HOME") .. "/Pictures/Screenshots/SILICON_${year}-${month}-${date}-${time}.png",
            bgColor = vim.g.terminal_color_5,
            bgImage = "", -- path to image, must be png
            roundCorner = true,
            windowControls = true,
            lineNumber = true,
            font = "JetBrainsMono Nerd Font",
            lineOffset = 1, -- from where to start line number
            linePad = 2,    -- padding between lines
            padHoriz = 80,  -- Horizontal padding
            padVert = 100,  -- vertical padding
            shadowBlurRadius = 10,
            shadowColor = "#555555",
            shadowOffsetX = 8,
            shadowOffsetY = 8,
            gobble = true, -- enable lsautogobble like feature
            debug = true,  -- enable debug output
        }
    }
}
