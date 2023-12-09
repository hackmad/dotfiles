return {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    event = "VeryLazy",
    config = function()
        require("fidget").setup {
            progress = {
                display = {
                    progress_icon = { pattern = "moon" },
                },
            },
            notification = {
                window = {
                    winblend = 50,
                },
            },
        }
    end,
}
