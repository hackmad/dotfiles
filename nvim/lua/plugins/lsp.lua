return {
        "neovim/nvim-lspconfig",
        dependencies = {
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                dependencies = {
                    {"williamboman/mason.nvim"},
                }
            },
            {
                "jay-babu/mason-nvim-dap.nvim",
                event = "BufRead",
                dependencies = {
                    { "williamboman/mason.nvim" },
                    { "mfussenegger/nvim-dap" },
                },
                enabled = vim.fn.has "win32" == 0,
            },
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/nvim-cmp"},
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            }
        },
        config = function()
            ---
            -- LSP Setup
            ---

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig = require "lspconfig"
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lspconfig_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = {buffer = event.buf}

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            -- Setup Mason
            require("mason").setup({})

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                },
            })

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
                    "bashls",
                    "clangd",
                    "clang-format",
                    "cmake",
                    "cpplint",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "stylua",
                },
            })

            -- Configure language servers
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }

            ---
            -- Autocompletion config
            ---
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                sources = {
                    {name = "nvim_lsp"},
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- Scroll up and down in the completion documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),

                    -- Use Tab and S-Tab for next/previous entry.
                    --["<Tab>"] = cmp.mapping(function (fallback)
                    --    if luasnip.expandable() then
                    --        luasnip.expand()
                    --    elseif cmp.visible() then
                    --        cmp.select_next_item()
                    --    elseif luasnip.jumpable(1) then
                    --        luasnip.jump(1)
                    --    elseif vim.api.nvim_get_mode().mode == 'i' then
                    --        tabout.tabout()
                    --    else
                    --        fallback()
                    --    end
                    --end, {'i', 's'}),
                    --["<S-Tab>"] = cmp.mapping(function (fallback)
                    --    if cmp.visible() then
                    --        cmp.select_prev_item()
                    --    elseif luasnip.jumpable(-1) then
                    --        luasnip.jump(-1)
                    --    else
                    --        fallback()
                    --    end
                    --end, {'i', 's'}),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
}

