return {
    "akinsho/flutter-tools.nvim",
    event = "VeryLazy", -- TODO automatically detect Flutter projects and load it.
    dependencies = {
        "nvim-lua/plenary.nvim",
        "dart-lang/dart-vim-plugin",
        "thosakwe/vim-flutter",
        "natebosch/vim-lsc",
        "natebosch/vim-lsc-dart",
    },
    config = function()
        require("flutter-tools").setup {}
        require("telescope").load_extension "flutter"
    end,
}
