vim.pack.add({
	{ src = "https://github.com/j-hui/fidget.nvim", version = vim.version.range("1.0") },
})

require("fidget").setup({
	progress = {
		display = {
			progress_icon = { pattern = "moon" },
		},
	},
	notification = {
		window = {
			winblend = 50,
		},
	},
})
