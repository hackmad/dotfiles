return {
    "mfussenegger/nvim-jdtls",
    lazy = true,
    ft = { "java" },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "mfussenegger/nvim-dap" },
    },
    config = function()
        local jdtls = require "jdtls"
        local jdtls_path = "/usr/local/Cellar/jdtls/1.23.0/libexec"
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.expand("$HOME" .. "/.workspace/" .. project_name)

        local cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-jar",
            vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

            "-configuration",
            jdtls_path .. "/config_mac",

            "-data",
            workspace_dir,
        }

        local settings = {
            java = {
                eclipse = { downloadSources = true },
                configuration = {
                    updateBuildConfiguration = "interactive",
                    runtimes = {},
                },
                maven = { downloadSources = true },
                implementationsCodeLens = { enabled = true },
                referencesCodeLens = { enabled = true },
                format = { enabled = true },
            },
            signatureHelp = {
                enabled = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            contentProvider = {
                preferred = "fernflower",
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        }

        local bundles = {
            vim.fn.glob(
                vim.fn.expand(
                    "$HOME"
                    .. "/Software/java-debug//com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
                    1
                )
            ),
        }
        vim.list_extend(
            bundles,
            vim.split(vim.fn.glob(vim.fn.expand("$HOME" .. "/Software/vscode-java-test/server/*.jar"), 1), "\n")
        )

        -- Debug settings if you're using nvim-dap
        local dap = require "dap"
        dap.configurations.java = {}

        local on_attach = function(client, bufnr)
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
            require("jdtls.setup").add_commands()
        end

        jdtls.start_or_attach {
            cmd = cmd,
            settings = settings,
            init_options = { bundles = bundles },
            on_attach = on_attach,
        }
    end,
}
