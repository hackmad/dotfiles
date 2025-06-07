local highlights = {
    Comment = { fg = "#00d060" },
    ColorColumn = { bg = "#151515" },
    VertSplit = { fg = "#303030" },

    CursorLineNr = { fg = "cyan" },
    LineNr = { fg = "#d0d0d0" },

    NonText = { fg = "#000000" },

    FidgetTitle = { fg = "#e0a0a0" },
    FidgetTask = { fg = "#e0e0a0" },

    St_gitIcons = { fg = "#80ff80" },

    FloatBorder = { fg = "#8080b0" },
}

for group, config in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, config)
end
