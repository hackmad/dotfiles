return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				themable = true,
				hover = {
					enabled = true,
					delay = 150,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "󰙅  File Explorer",
						separator = true,
					},
				},
				custom_areas = {
					right = require("visual_studio_code").get_bufferline_right(),
				},
			},
		})
	end,
}
