return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        local status_ok, bufferline = pcall(require, "bufferline")
        if not status_ok then
            return
        end

        bufferline.setup {
            options = {
                hover = {
                    enabled = true,
                    delay = 150,
                    reveal = { 'close' }
                }
            }
        }
    end,
}
