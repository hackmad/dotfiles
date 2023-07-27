return {
    "VonHeikemen/lsp-zero.nvim",
    event = "VeryLazy",
    branch = "v2.x",
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
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup {
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "gopls",
                "groovyls",
                "jsonls",
                "kotlin_language_server",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "terraformls",
            },
        }

        require("mason-nvim-dap").setup {
            automatic_setup = true,
            ensure_installed = {
                "codelldb",
                "cppdbg",
                "kotlin-debug-adapter",
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

        local lsp = require("lsp-zero").preset({
            manage_nvim_cmp = {
                set_sources = "recommended",
            },
        })

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = true })
        end)

        lsp.ensure_installed({
            -- Replace these with whatever servers you want to install
        })

        -- (Optional) Configure lua language server for neovim
        local lspconfig = require "lspconfig"
        lspconfig.clangd.setup {}
        lspconfig.cmake.setup {}
        lspconfig.groovyls.setup {}
        lspconfig.kotlin_language_server.setup {}
        lspconfig.jsonls.setup {}
        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
        lspconfig.pyright.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.terraformls.setup {}

        lsp.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["lua_ls"] = { "lua" },
                ["rust_analyzer"] = { "rust" },
                -- if you have a working setup with null-ls you can specify filetypes it can format.
                --["null-ls"] = { "typescript" },
            }
        })

        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()
        cmp.setup({
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp_action.tab_complete(),
                ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
            }
        })

        lsp.setup()

        -- (Optional) Configure debug adapters
        local dap = require("dap");
        dap.configurations.kotlin = {
            {
                type = 'kotlin',
                request = 'launch',
                name = 'Launch Kotlin app',
                projectRoot = "${workspaceFolder}/app",
                mainClass = function()
                    local main_class = vim.fn.input("Main class: ")
                    return main_class
                end,
            },
        }
        dap.defaults.kotlin.auto_continue_if_many_stopped = false
    end,
}
