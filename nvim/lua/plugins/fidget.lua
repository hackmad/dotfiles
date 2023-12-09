return {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
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
