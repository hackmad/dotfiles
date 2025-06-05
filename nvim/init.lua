if vim.g.vscode then
    -- VSCode Extension
    require "vscode-config"
else
    -- Ordinary NeoVim
    require("core.lsp")

    require("config.options")
    require("config.keymaps")
    require("config.autocmds")
    require("config.highlights")

    require("core.lazy")
end
