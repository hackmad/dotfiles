local highlights = {
	Comment = { fg = "#00d060" },
	ColorColumn = { bg = "#151515" },
	VertSplit = { fg = "#303030" },

	CursorLineNr = { fg = "cyan" },
	LineNr = { fg = "#d0d0d0" },

	FidgetTitle = { fg = "#e0a0a0" },
	FidgetTask = { fg = "#e0e0a0" },

	St_gitIcons = { fg = "#80ff80" },

	FloatBorder = { fg = "#8080b0" },

	NonText = { fg = "#808080" },

	--SnacksPickerDir = { fg = "#a0a0a0" },
	--SnacksPickerTotals = { fg = "#808080" },
	--SnacksPickerPathIgnored = { fg = "#606060" },
	--SnacksPickerPathHidden = { fg = "#606060" },
	--SnacksPickerGitStatusIgnored = { fg = "#606060" },
	--SnacksPickerGitStatusUntracked = { fg = "#ff7070" },
}

for group, config in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, config)
end
