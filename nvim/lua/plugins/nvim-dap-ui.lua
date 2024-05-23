return {
    "rcarriga/nvim-dap-ui",
    event = "BufRead",
    dependencies = {
        { "mfussenegger/nvim-dap" },
        { "nvim-neotest/nvim-nio" },
    },
    enabled = vim.fn.has "win32" == 0,
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup {}

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
}
