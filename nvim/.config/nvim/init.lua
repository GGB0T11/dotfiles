-- Carregar configurações principais
require("config.options")
require("config.autocommands")
require("config.keymaps")
require("config.lazy")

-- Carregar configurações de plugins
require("plugins.lsp")
require("plugins.navigation")
require("plugins.utils")
require("plugins.completions")
require("plugins.appearance")
require("plugins.debugging")

-- Definir tema
vim.cmd.colorscheme("gruvbox")
