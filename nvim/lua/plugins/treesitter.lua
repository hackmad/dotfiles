local autocmd = vim.api.nvim_create_autocmd

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context", version = "v1.0.0" },
})

local nts = require("nvim-treesitter")

nts.setup({
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

nts.install({
	"bash",
	"c",
	"dockerfile",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"html",
	"javascript",
	"json",
	"lua",
	"make",
	"markdown",
	"python",
	"query",
	"regex",
	"rust",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
})

autocmd("PackChanged", {
	callback = function()
		nts.update()
	end,
})
