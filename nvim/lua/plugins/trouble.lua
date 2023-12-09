return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        require("trouble").setup {
            auto_open = false,
            auto_close = false,
            mod = "document_diagnosis",
        }
    end,
}
