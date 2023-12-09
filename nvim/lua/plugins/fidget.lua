return {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    config = function()
        require("fidget").setup {
            progress = {
                display = {
                    done_icon = "✔",
                    progress_icon = { "moon" },
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
