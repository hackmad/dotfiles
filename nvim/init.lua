if vim.g.vscode then
    -- VSCode Extension
    require "vscode-config"
else
    -- Ordinary NeoVim
    require "keymaps"
    require "options"
    require "lazy-config"
    require "highlights"
end
