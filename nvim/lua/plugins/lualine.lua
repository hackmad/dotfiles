vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup({
	options = {
		theme = "visual_studio_code",
		theme = "moonfly",
	},
})
