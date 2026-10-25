vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
})

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "󰙅 Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
})
