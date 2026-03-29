vim.pack.add({
    { src = "https://github.com/akinsho/nvim-bufferline.lua" },
})

require("bufferline").setup({
    options = {
        themable = true,
        hover = {
            enabled = true,
            delay = 150,
            reveal = { "close" },
        },
        offsets = {
            {
                filetype = "snacks_layout_box",
                text = "󰙅  File Explorer",
                separator = true,
            },
        },
        custom_areas = {
            --right = require("visual_studio_code").get_bufferline_right(),
        },
    },
})
