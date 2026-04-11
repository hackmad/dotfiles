if vim.g.vscode then
	-- VSCode Extension
	require("vscode-config")
else
	require("config.options")
	require("config.keymaps")
	require("config.autocmds")

	require("plugins.blink")
	require("plugins.bufdelete")
	require("plugins.bufferline")
	require("plugins.colorscheme")
	require("plugins.conform")
	require("plugins.fidget")
	require("plugins.gitsigns")
	require("plugins.lualine")
	require("plugins.mason")
	require("plugins.nvim-tree")
	require("plugins.telescope")
	require("plugins.treesitter")
	require("plugins.vim-sleuth")
	require("plugins.which-key")

	require("plugins.lsp")

	require("config.highlights")

	-- Show intro screen
	vim.opt.shortmess:remove("I")
end
