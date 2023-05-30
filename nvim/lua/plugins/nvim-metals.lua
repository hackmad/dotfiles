return {
    "scalameta/nvim-metals",
    event = "BufRead",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "mfussenegger/nvim-dap" },
    },
    ft = { "sbt", "scala" },
    config = function()
        local metals_config = require("metals").bare_config()

        metals_config.settings = {
            showImplicitArguments = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            testUserInterface = "Test Explorer",
        }

        metals_config.init_options.statusBarProvider = "on"
        metals_config.handlers["metals/status"] = function(_, status, ctx)
            -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
            local val = {}
            if status.hide then
                val = { kind = "end" }
            elseif status.show then
                val = { kind = "begin", message = status.text }
            elseif status.text then
                val = { kind = "report", message = status.text }
            else
                return
            end
            local info = { client_id = ctx.client_id }
            local msg = { token = "metals", value = val }
            -- call fidget progress handler
            vim.lsp.handlers["$/progress"](nil, msg, info)
        end

        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Debug settings if you're using nvim-dap
        local dap = require "dap"

        dap.configurations.scala = {
            {
                type = "scala",
                request = "launch",
                name = "RunOrTest",
                metals = {
                    runType = "runOrTestFile",
                },
            },
            {
                type = "scala",
                request = "launch",
                name = "Test Target",
                metals = {
                    runType = "testTarget",
                },
            },
        }

        metals_config.on_attach = function(client, bufnr)
            require("metals").setup_dap()
        end

        -- Autocmd that will actually be in charging of starting the whole thing
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            -- NOTE: You may or may not want java included here. You will need it if you
            -- want basic Java support but it may also conflict if you are using
            -- something like nvim-jdtls which also works on a java filetype autocmd.
            pattern = {
                "scala",
                "sbt",
                --"java",
            },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
