local status_ok, impatient = pcall(require, "impatient")
if status_ok then
    impatient.enable_profile()
end

require("user.core")
require("user.plugins")
require("user.lsp")
