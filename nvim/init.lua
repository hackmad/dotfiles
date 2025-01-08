if vim.g.vscode then
    -- VSCode Extension
    require "vscode-config"
else
    -- Ordinary NeoVim
    require "options"
    require "keymaps"
    require "lazy-config"
    require "highlights"
end
