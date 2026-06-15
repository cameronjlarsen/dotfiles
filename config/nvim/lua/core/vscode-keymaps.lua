-- Maps for Cursor/VS Code when plugins (Telescope, LSP, gitsigns, etc.) are not loaded.
-- Uses vscode-neovim's VSCodeNotify; leader and base maps come from core/keymaps.lua.
local function notify(cmd)
    vim.fn.VSCodeNotify(cmd)
end

local map = Utils.map

-- ——— Telescope / picker equivalents ———
map("n", "<leader>ff", function() notify("workbench.action.quickOpen") end, { desc = "Files (Quick Open)" })
map("n", "<leader>ft", function() notify("workbench.action.findInFiles") end, { desc = "Find in Files" })
map("v", "<leader>ft", function() notify("workbench.action.findInFiles") end, { desc = "Find in Files" })
map("n", "<leader>fb", function() notify("actions.find") end, { desc = "Find in Buffer" })
map("n", "<leader>fc", function() notify("workbench.action.showCommands") end, { desc = "Command Palette" })
map("n", "<leader>bb", function() notify("workbench.action.showAllEditors") end, { desc = "Buffers / editors" })
map("n", "<leader>fh", function() notify("workbench.action.openWalkthrough") end, { desc = "Help / walkthrough" })
map("n", "<leader>fk", function() notify("workbench.action.openGlobalKeybindings") end, { desc = "Keyboard shortcuts" })
map("n", "<leader>fo", function() notify("workbench.action.openRecent") end, { desc = "Recent files" })
map("n", "<leader>fl", function() notify("workbench.action.openPreviousEditorFromHistory") end, { desc = "Previous editor" })
map("n", "<leader>fn", function() notify("notifications.showList") end, { desc = "Notifications" })
map("n", "<leader>fv", function() notify("workbench.action.openSettings") end, { desc = "Settings" })
map("n", "<leader>fs", function() notify("workbench.action.gotoSymbol") end, { desc = "Document symbols" })
map("n", "<leader>fM", function() notify("workbench.action.showCommands") end, { desc = "Commands (man pages N/A)" })
map("n", "<leader>fe", function() notify("workbench.view.explorer") end, { desc = "Explorer" })
map("n", "<leader>fE", function() notify("workbench.files.action.showActiveFileInExplorer") end,
    { desc = "Reveal file in explorer" })
map("n", "<leader>fp", function() notify("workbench.action.addRootFolder") end, { desc = "Add folder to workspace" })
map("n", "<leader>fgb", function() notify("git.checkout") end, { desc = "Git: Checkout" })
map("n", "<leader>fgc", function() notify("workbench.view.scm") end, { desc = "Git commits / SCM (use Timeline for file history)" })
map("n", "<leader>fgs", function() notify("workbench.view.scm") end, { desc = "Source control" })
map("n", "<leader>fw", function() notify("workbench.action.findInFiles") end, { desc = "Find in files (word: use query)" })
map("n", "<leader>fT", function() notify("workbench.action.quickOpen") end, { desc = "Quick open" })

-- ——— Bufferline ———
map("n", "<leader>bn", function() notify("workbench.action.nextEditorInGroup") end, { desc = "Next buffer" })
map("n", "<leader>bp", function() notify("workbench.action.previousEditorInGroup") end, { desc = "Prev buffer" })

-- ——— vim-bbye style ———
map("n", "<leader>bc", function() notify("workbench.action.closeActiveEditor") end, { desc = "Close buffer" })
map("n", "<leader>bd", function() notify("workbench.action.closeActiveEditor") end, { desc = "Close buffer" })

-- ——— Git (lazygit → SCM; install a LazyGit extension for a closer match) ———
map("n", "<leader>gg", function() notify("workbench.view.scm") end, { desc = "Source control (LazyGit N/A)" })

-- ——— Gitsigns-style (built-in SCM / diff navigation) ———
map("n", "]h", function() notify("editor.action.dirtydiff.next") end, { desc = "Next change" })
map("n", "[h", function() notify("editor.action.dirtydiff.previous") end, { desc = "Prev change" })
map("n", "<leader>ghs", function() notify("git.diff.stageHunk") end, { desc = "Stage hunk" })
map("n", "<leader>ghr", function() notify("git.revertChange") end, { desc = "Revert hunk" })
map("n", "<leader>ghp", function() notify("git.openChange") end, { desc = "Open diff" })
map("n", "<leader>ghb", function() notify("git.blame.toggleEditorDecoration") end, { desc = "Toggle blame" })

-- ——— LSP (Neovim LSP is skipped in vscode) ———
map("n", "gd", function() notify("editor.action.revealDefinition") end, { desc = "Goto definition" })
map("n", "gD", function() notify("editor.action.revealDeclaration") end, { desc = "Goto declaration" })
map("n", "gi", function() notify("editor.action.goToImplementation") end, { desc = "Goto implementation" })
map("n", "gt", function() notify("editor.action.goToTypeDefinition") end, { desc = "Goto type definition" })
map("n", "gr", function() notify("editor.action.goToReferences") end, { desc = "References" })
map("n", "K", function() notify("editor.action.showHover") end, { desc = "Hover" })
map("i", "<C-k>", function() notify("editor.action.triggerParameterHints") end, { desc = "Signature help" })
map("n", "<C-k>", function() notify("editor.action.triggerParameterHints") end, { desc = "Signature help" })
map("n", "<leader>lf", function() notify("editor.action.formatDocument") end, { desc = "Format" })
map("v", "<leader>lf", function() notify("editor.action.formatSelection") end, { desc = "Format selection" })
map("n", "<leader>lr", function() notify("editor.action.rename") end, { desc = "Rename" })
map({ "n", "v" }, "<leader>la", function() notify("editor.action.sourceAction") end, { desc = "Source action" })
map("n", "gl", function() notify("editor.action.showHover") end, { desc = "Line diagnostic / hover" })
map("n", "[d", function() notify("editor.action.marker.prev") end, { desc = "Prev diagnostic" })
map("n", "]d", function() notify("editor.action.marker.next") end, { desc = "Next diagnostic" })
map("n", "<leader>ld", function() notify("workbench.actions.view.problems") end, { desc = "Problems" })
map("n", "<leader>lwd", function() notify("workbench.actions.view.problems") end, { desc = "Problems" })
map("n", "<leader>ls", function() notify("workbench.action.gotoSymbol") end, { desc = "Document symbols" })
map("n", "<leader>lws", function() notify("workbench.action.showAllSymbols") end, { desc = "Workspace symbols" })
map("n", "<leader>lv", function() notify("workbench.actions.view.problems") end, { desc = "Diagnostics / problems" })
map("n", "<leader>lt", function() notify("workbench.actions.view.problems") end, { desc = "Toggle problems view" })

-- ——— Debug (DAP → VS Code debug) ———
map("n", "<leader>db", function() notify("editor.debug.action.toggleBreakpoint") end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function() notify("workbench.action.debug.start") end, { desc = "Start / continue" })
map("n", "<leader>dO", function() notify("workbench.action.debug.stepOver") end, { desc = "Step over" })
map("n", "<leader>di", function() notify("workbench.action.debug.stepInto") end, { desc = "Step into" })
map("n", "<leader>do", function() notify("workbench.action.debug.stepOut") end, { desc = "Step out" })
map("n", "<leader>dt", function() notify("workbench.action.debug.stop") end, { desc = "Stop" })
map("n", "<leader>du", function() notify("workbench.view.debug") end, { desc = "Debug view" })

-- ——— Terminal (toggleterm not loaded) ———
map({ "n", "i", "t" }, "<M-t>", function() notify("workbench.action.terminal.toggle") end, { desc = "Toggle terminal" })
map("n", "<leader>tt", function() notify("workbench.action.terminal.toggle") end, { desc = "Terminal" })
map("n", "<leader>tv", function() notify("workbench.action.terminal.split") end, { desc = "Split terminal" })
map("n", "<leader>th", function() notify("workbench.action.terminal.new") end, { desc = "New terminal" })
