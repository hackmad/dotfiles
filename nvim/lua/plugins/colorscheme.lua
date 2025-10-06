return {
	"askfiy/visual_studio_code",
	priority = 100,
	config = function()
		vim.cmd([[colorscheme visual_studio_code]])
	end,
}
-- return {
-- 	"bluz71/vim-moonfly-colors",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		vim.api.nvim_command("colorscheme moonfly")
-- 	end,
-- }
