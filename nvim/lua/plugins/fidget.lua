return {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
        local status_ok, fidget = pcall(require, "fidget")
        if not status_ok then
            return
        end

        fidget.setup {
            text = {
                spinner = "moon",
                done = "✔",
                commenced = "Started",
                completed = "Completed",
            },
            window = {
                blend = 50,
            },
        }
    end,
}