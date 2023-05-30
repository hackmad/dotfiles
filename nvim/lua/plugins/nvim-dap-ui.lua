return {
    "rcarriga/nvim-dap-ui",
    event = "BufRead",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    enabled = vim.fn.has "win32" == 0,
    config = function()
        local dap_status_ok, dap = pcall(require, "dap")
        if not dap_status_ok then
            return
        end

        local dap_ui_status_ok, dapui = pcall(require, "dapui")
        if not dap_ui_status_ok then
            return
        end

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
