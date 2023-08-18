local opt = vim.opt

opt.relativenumber = true
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<A-j>", "<esc>:m .+1<cr>==gi", opts)
keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)
keymap("n", "<C-w>_", ":<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>", opts)
