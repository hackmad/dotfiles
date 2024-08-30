return {
    "VonHeikemen/lsp-zero.nvim",
    event = "VeryLazy",
    branch = "v3.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        },

        -- LSPs
        { "williamboman/mason-lspconfig.nvim" },

        -- Linters/Formatters
        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            dependencies = {
                { 'williamboman/mason.nvim' },
            }
        },

        -- DAP
        {
            "jay-babu/mason-nvim-dap.nvim",
            event        = "BufRead",
            dependencies = {
                { "williamboman/mason.nvim" },
                { "mfussenegger/nvim-dap" },
            },
            enabled      = vim.fn.has "win32" == 0,
        },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
        local lsp_zero = require("lsp-zero").preset({
            manage_nvim_cmp = {
                set_sources = "recommended",
            },
        })

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = true })
        end)

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["lua_ls"] = { "lua" },
                ["rust_analyzer"] = { "rust" },
                ["pyright"] = { "python" },
                ["clangd"] = { "c", "cpp" },
            },
        })

        local cmp = require("cmp")
        local cmp_action = lsp_zero.cmp_action()
        cmp.setup({
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp_action.tab_complete(),
                ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
            }
        })

        lsp_zero.setup()

        require("mason").setup()

        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup {
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "gopls",
                "jsonls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "terraformls",
            },
            automatic_installation = true,
            handlers = {
                lsp_zero.default_setup,
            }
        }

        mason_lspconfig.setup_handlers {
            -- Default handler
            function(server_name)
                lspconfig[server_name].setup {}
            end,

            -- Specific handlers
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
            end,
        }

        require("mason-nvim-dap").setup {
            automatic_setup = true,
            ensure_installed = {
                "codelldb",
                "cppdbg",
                "python",
            },
            handlers = {
                function(config)
                    -- all sources with no handler get passed here

                    -- Keep original functionality
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        }

        require("mason-tool-installer").setup({
            ensure_installed = {
                "clang-format",
                "cpplint",
                "stylua",
            },
        })

        -- (Optional) Configure debug adapters
        -- local dap = require("dap");
    end,
}
