require "keymaps"
require "options"
require "lazy-config"

if vim.g.vscode then
    -- VSCode Extension
    require "vscode"
else
    -- Ordinary NeoVim
    require "highlights"
end
