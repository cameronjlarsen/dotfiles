_G.Utils = require("core.utils")

require("core.options")
require("core.keymaps")
if vim.g.vscode then
    require("core.vscode-keymaps")
end
require("core.commands")
require("core.lazy")
