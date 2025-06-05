local opt = vim.opt
local g = vim.g

-- Disable perl
g.loaded_perl_provider = 0

-- nvim-tree related options
-- disable netrw at the very start of your init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Fix markdown indentation settings
g.markdown_recommended_style = 0

opt.autowrite = true          -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3          -- Hide * markup for bold and italic
opt.confirm = true            -- Confirm to save changes before exiting modified buffer
opt.cursorline = true         -- Enable highlighting of the current line
opt.expandtab = true          -- Use spaces instead of tabs
opt.foldenable = true         -- Code folding
opt.foldcolumn = '1'          -- '0' is not bad
opt.foldlevel = 99            --  Using ufo provider needs a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = false     -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.incsearch = true
opt.laststatus = 0
opt.list = true           -- Show some invisible characters like tabs and trailing spaces
opt.mouse = "a"           -- Enable mouse mode
opt.number = true         -- Print line number
opt.pumblend = 10         -- Popup blend
opt.pumheight = 10        -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 5         -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true     -- Round indent
opt.shiftwidth = 4        -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false      -- Dont show mode since we have a statusline
opt.sidescrolloff = 8     -- Columns of context
opt.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true      -- Don't ignore case with capitals
opt.smartindent = true    -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true     -- Put new windows below current
opt.splitright = true     -- Put new windows right of current
opt.tabstop = 4           -- Number of spaces tabs count for
opt.termguicolors = true  -- True color support
opt.timeoutlen = 500      -- Speed must be under 500ms in order for keys to work, increase if you aren't able to
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap
opt.termguicolors = true           -- set termguicolors to enable highlight groups
opt.colorcolumn = "120"            -- nice wide 120 columns

