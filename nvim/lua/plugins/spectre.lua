return {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
    },
    config = function()
        require("spectre").setup {
            default = {
                find = {
                    --pick one of item in find_engine
                    options = {}
                },
            },
        }
    end,
}
