local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local home = os.getenv("HOME")
local dashboard = require("alpha.themes.dashboard")

local function heading_info()
    local datetime = os.date("  %m-%d-%Y  󰥔  %I:%M %p")
    local version = vim.version()
    ---@diagnostic disable-next-line: need-check-nil
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. nvim_version_info
end

local function footer_info()
    -- Get number of plugins loaded by packer
    ---@diagnostic disable-next-line: param-type-mismatch
    local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1))
    return "Neovim loaded " .. plugins_count .. " plugins "
end

local Headers = {
    NEOVIM = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    },
    OCTOPI = {
        [[                                    ██████                                    ]],
        [[                                ████▒▒▒▒▒▒████                                ]],
        [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
        [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
        [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
        [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
        [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
        [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
        [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
        [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
        [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
        [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
        [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
        [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
        [[                        ██      ██      ████      ████                        ]],
    },
    SEASONAL = {
        XMAS = {
            [[                                                        *                 ]],
            [[     *                                                          *         ]],
            [[                                  *                  *        .--.        ]],
            [[     \/ \/  \/  \/                                        ./   /=*        ]],
            [[        \/     \/      *            *                ...  (_____)         ]],
            [[        \ ^ ^/                                       \ \_((^o^))-.     *  ]],
            [[        (o)(O)--)--------\.                           \   (   ) \  \._.   ]],
            [[        |    |  ||================((~~~~~~~~~~~~~~~~~))|   ( )   |     \  ]],
            [[         \__/             ,|        \. * * * * * * ./  (~~~~~~~~~~~)    \ ]],
            [[  *        ||^||\.____./|| |          \___________/     ~||~~~~|~'\____/ *]],
            [[           || ||     || || A            ||    ||          ||    |   jurcy ]],
            [[    *      <> <>     <> <>          (___||____||_____)   ((~~~~~|   *     ]],
        },
        HALLOWEEN = {
            [[                                             ,           ^'^  _      ]],
            [[                                             )               (_) ^'^ ]],
            [[        _/\_                    .---------. ((        ^'^            ]],
            [[        (('>                    )`'`'`'`'`( ||                 ^'^   ]],
            [[   _    /^|                    /`'`'`'`'`'`\||           ^'^         ]],
            [[   =>--/__|m---               /`'`'`'`'`'`'`\|                       ]],
            [[        ^^           ,,,,,,, /`'`'`'`'`'`'`'`\      ,                ]],
            [[                    .-------.`|`````````````|`  .   )                ]],
            [[                   / .^. .^. \|  ,^^, ,^^,  |  / \ ((                ]],
            [[                  /  |_| |_|  \  |__| |__|  | /,-,\||                ]],
            [[       _         /_____________\ |")| |  |  |/ |_| \|                ]],
            [[      (")         |  __   __  |  '==' '=='  /_______\     _          ]],
            [[     (' ')        | /  \ /  \ |   _______   |,^, ,^,|    (")         ]],
            [[      \  \        | |--| |--| |  ((--.--))  ||_| |_||   (' ')        ]],
            [[    _  ^^^ _      | |__| |("| |  ||  |  ||  |,-, ,-,|   /  /         ]],
            [[  ,' ',  ,' ',    |           |  ||  |  ||  ||_| |_||   ^^^          ]],
            [[.,,|RIP|,.|RIP|,.,,'==========='==''=='==''=='=======',,....,,,,.,ldb]],
        },
        SUMMER = {
            [[                              _                         ]],
            [[                           ,--.\`-. __                  ]],
            [[                         _,.`. \:/,"  `-._              ]],
            [[                    ,-*" _,.-;-*`-.+"*._ )              ]],
            [[                   ( ,."* ,-" / `.  \.  `.              ]],
            [[                  ,"   ,;"  ,"\../\  \:   \             ]],
            [[                 (   ,"/   / \.,' :   ))  /             ]],
            [[                  \  |/   / \.,'  /  // ,'              ]],
            [[                   \_)\ ,' \.,'  (  / )/                ]],
            [[                       `  \._,'   `"                    ]],
            [[                          \../                          ]],
            [[                          \../                          ]],
            [[                ~        ~\../           ~~             ]],
            [[         ~~          ~~   \../   ~~   ~      ~~         ]],
            [[    ~~    ~   ~~  __...---\../-...__ ~~~     ~~         ]],
            [[      ~~~~  ~_,--'        \../      `--.__ ~~    ~~     ]],
            [[  ~~~  __,--'              `"             `--.__   ~~~  ]],
            [[~~  ,--'                                         `--.   ]],
            [[  '------......______             ______......------` ~~]],
            [[~~~   ~    ~~      ~ `````---"""""  ~~   ~     ~~       ]],
            [[       ~~~~    ~~  ~~~~       ~~~~~~  ~ ~~   ~~ ~~~  ~  ]],
            [[    ~~   ~   ~~~     ~~~ ~         ~~       ~~   SSt    ]],
            [[             ~        ~~       ~~~       ~              ]],
        },
    },
}

local header = {
    type = "text",
    val = Headers.OCTOPI,
    opts = {
        position = "center",
        hl = "DashboardHeader",
    },
}

local heading = {
    type = "text",
    val = heading_info(),
    opts = {
        position = "center",
        hl = "DashboardCenter",
    },
}

local buttons = {
    type = "group",
    val = {
        dashboard.button("f", "󰈞  Find file", "<cmd>lua require('configs.telescope').find_files() <CR>", {}),
        dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>", {}),
        dashboard.button("p", "  Find project", "<cmd>Telescope projects <CR>", {}),
        dashboard.button("r", "󰄉  Recently used files", "<cmd>Telescope oldfiles <CR>", {}),
        dashboard.button("t", "󰊄  Find text",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {}),
        dashboard.button("c", "  Configuration", "<cmd>e" .. home .. "/.config/nvim/init.lua | :cd %:p:h<CR>", {}),
        dashboard.button("q", "󰅚  Quit Neovim", "<cmd>qa<CR>", {}),
    },
    opts = {
        position = "center",
        spacing = 1,
        hl = "DashboardShortcut",
    },
}

local footer = {
    type = "text",
    val = footer_info(),
    opts = {
        position = "center",
        hl = "DashboardFooter",
    },
}

local section = {
    header = header,
    heading = heading,
    buttons = buttons,
    footer = footer,
}

-- Set padding
local occupied_lines = {
    -- occupied lines
    header = #header.val,           -- CONST: number of lines that your header will occupy
    heading = 1,                    -- CONST: number of lines that your heading will occupy
    buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
    footer = 1,                     -- CONST: number of lines that the footer will occupy
}

local function calculate_padding()
    return vim.fn.winheight(0) -
        (occupied_lines.header + occupied_lines.heading + occupied_lines.buttons + occupied_lines.footer)
end
local total_padding = calculate_padding()
-- If the padding is negative, then we need to reduce the spacing between buttons
if total_padding <= 0 then
    buttons.opts.spacing = 0
    occupied_lines.buttons = #buttons.val
    total_padding = calculate_padding()
end
local top_padding = vim.fn.max({ 2, vim.fn.floor(total_padding * 0.25) })
local middle_padding = vim.fn.max({ 2, vim.fn.floor(total_padding * 0.20) })
local bottom_padding = vim.fn.max({ 2, vim.fn.ceil(total_padding * 0.30) })

local config = {
    layout = {
        { type = "padding", val = top_padding },
        section.header,
        { type = "padding", val = middle_padding },
        section.heading,
        { type = "padding", val = middle_padding },
        section.buttons,
        { type = "padding", val = middle_padding },
        section.footer,
        { type = "padding", val = bottom_padding },
    },
    opts = {
        margin = 5
    },
}

alpha.setup(config)
