local autocmd = vim.api.nvim_create_autocmd

-- LSP
vim.lsp.enable({
	"lua_ls",
	"rust-analyzer",
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				preloadFileSize = 10000,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

vim.lsp.config("rust-analyzer", {
	settings = {
		["rust-analyzer"] = {},
	},
})

vim.diagnostic.config({
	virtual_lines = false,
	-- virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

autocmd("LspAttach", {
	group = augroup,
	callback = function(ev)
		local bufopts = { noremap = true, silent = true, buffer = ev.buf }
		map("n", "grd", vim.lsp.buf.definition, bufopts)
		map("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local methods = vim.lsp.protocol.Methods
		if client:supports_method(methods.textDocument_completion) then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
