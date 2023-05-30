return {
    "ojroques/nvim-bufdel",
    lazy = false,
    config = function()
        require("bufdel").setup {
            next = "tabs",
            quit = false, -- Don't quit Neovim when last buffer is closed
        }
    end,
}
