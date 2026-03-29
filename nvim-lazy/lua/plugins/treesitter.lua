return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"norg",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"svelte",
				"terraform",
				"tsx",
				"typescript",
				"typst",
				"vim",
				"vue",
				"wgsl",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					node_decremental = "<leader>sd",
					scope_incremental = "<leader>sc",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookaround = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
						["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
						["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["as"] = {
							query = "@scope",
							query_group = "locals",
							desc = "Select inner part of a class region",
						},
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "v", -- linewise
						["@class.outer"] = "<C-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
			},
		})
	end,
}
