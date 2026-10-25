vim.pack.add({
	"https://github.com/xiyaowong/transparent.nvim",
})

require("transparent").setup({
	extra_groups = {
		-- Floating windows and Telescope
		"NormalFloat",
		"FloatBorder",
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",

		-- NvimTree and sign column
		"NvimTreeNormal",
		"NvimTreeNormalNC",
		"NvimTreeEndOfBuffer",
		"CursorLineSign",
	},
})

-- Plugin groups generated dynamically
require("transparent").clear_prefix("BufferLine")
require("transparent").clear_prefix("lualine")
require("transparent").clear_prefix("NvimTree")
require("transparent").clear_prefix("Telescope")

-- Enable transparency through the Lua API
require("transparent").clear_prefix("")
