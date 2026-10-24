vim.pack.add({
	{ src = "https://codeberg.org/ziglang/zig.vim" },
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
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
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {},
	},
})

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.zig", "*.zon" },
	callback = function(ev)
		vim.lsp.buf.format()

		vim.lsp.buf.code_action({
			context = { only = { "source.fixAll" } },
			apply = true,
		})

		vim.lsp.buf.code_action({
			context = { only = { "source.organizeImports" } },
			apply = true,
		})
	end,
})

vim.lsp.config("zls", {
	-- Set to "zls" if `zls` is in your PATH
	--cmd = { "/usr/bin/zls" },
	cmd = { "zls" },
	filetypes = { "zig" },
	root_markers = { "build.zig" },
	settings = {
		zls = {
			-- Whether to enable build-on-save diagnostics
			-- enable_build_on_save = true,

			-- omit the following line if `zig` is in your PATH
			--zig_exe_path = "/usr/bin/zig",
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"rust-analyzer",
	"zls",
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
	group = augroup("hackmad.lsp", { clear = true }),
	callback = function(ev)
		local bufopts = { noremap = true, silent = true, buffer = ev.buf }
		vim.keymap.set("n", "grd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local methods = vim.lsp.protocol.Methods
		if client:supports_method(methods.textDocument_completion) then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
