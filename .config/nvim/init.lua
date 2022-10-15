local status_ok, impatient = pcall(require, "impatient")
if status_ok then
    impatient.enable_profile()
end

impatient.enable_profile()
require("user.core")
require("user.colorscheme")
require("user.plugins")
require("user.lsp")
