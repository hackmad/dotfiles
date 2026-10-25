require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Include plugins that need to run first and/or are dependencies for other plugins.
require("plugins.colorscheme")
require("plugins.nvim-web-devicons")

require("plugins.blink")
require("plugins.bufdelete")
require("plugins.bufferline")
require("plugins.conform")
require("plugins.fidget")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.transparent")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.vim-sleuth")
require("plugins.which-key")

require("plugins.lsp")

require("config.highlights")

-- Show intro screen
vim.opt.shortmess:remove("I")
