vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require("telescope.builtin")

require("telescope").setup({
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})

function SearchClasses()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Class" },
		prompt_title = "Search Classes",
	})
end

function SearchFunctions()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Function", "Method" },
		prompt_title = "Search Functions",
	})
end

function SearchVariables()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Variable", "Constant" },
		prompt_title = "Search Variables",
	})
end

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sf", SearchFunctions, { desc = "Search functions" })
vim.keymap.set("n", "<leader>sc", SearchClasses, { desc = "Search classes" })
vim.keymap.set("n", "<leader>sv", SearchVariables, { desc = "Search variables" })
vim.keymap.set("n", "<leader>ss", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help tags" })
vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Quick fix" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
