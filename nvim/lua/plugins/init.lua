local plugins = {
	require "plugins.bufferline",
	require "plugins.colorscheme",
	require "plugins.fidget",
	require "plugins.gitsigns",
	require "plugins.lsp",
	require "plugins.markdown-preview",
	require "plugins.nvim-bufdel",
	require "plugins.nvim-dap-ui",
	require "plugins.nvim-tree",
	require "plugins.nvim-ufo",
	require "plugins.telescope",
	require "plugins.spectre",
	require "plugins.surround",
	require "plugins.treesitter",
	require "plugins.treesitter-context",
	require "plugins.treesitter-textobjects",
	require "plugins.trouble",
	require "plugins.vim-fugitive",

    -- This should be final plugin to load.
	require "plugins.which-key",
}

return plugins
