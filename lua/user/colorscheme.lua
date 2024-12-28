local M = {
	-- "LunarVim/darkplus.nvim",
	-- 'ChristianChiarulli/nvcode-color-schemes.vim',
	-- 'savq/melange-nvim',
	-- 'folke/tokyonight.nvim',
	-- 'RRethy/base16-nvim',
	-- 'bluz71/vim-moonfly-colors',
	-- 'ellisonleao/gruvbox.nvim',
	"sainnhe/gruvbox-material",
	-- 'mcchrish/zenbones.nvim',
	-- dependencies = {
	--   "rktjmp/lush.nvim"
	-- },
	-- 'EdenEast/nightfox.nvim',
	-- 'NTBBloodbath/sweetie.nvim',
	-- "rebelot/kanagawa.nvim",
	-- 'nyoom-engineering/oxocarbon.nvim',
	-- 'oxfist/night-owl.nvim',
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
	-- require("gruvbox").setup({
	-- 	contrast = "hard",
	-- })
	vim.cmd.colorscheme("gruvbox-material")
	vim.opt.background = "dark"
	vim.g.moonflyItalics = false
	vim.cmd.highlight("Normal ctermbg=none guibg=none")
	vim.cmd.highlight("NormalNC ctermbg=none guibg=none")
end

return M
