local M = {
	-- "LunarVim/darkplus.nvim",
	-- 'ChristianChiarulli/nvcode-color-schemes.vim',
	-- 'savq/melange-nvim',
	-- "folke/tokyonight.nvim",
	"AlexvZyl/nordic.nvim",
	-- "baliestri/aura-theme",
	-- 'RRethy/base16-nvim',
	-- 'bluz71/vim-moonfly-colors',
	-- 'ellisonleao/gruvbox.nvim',
	-- "sainnhe/gruvbox-material",
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

function M.config(plugin)
	-- require("gruvbox").setup({
	-- 	contrast = "hard",
	-- })
	-- vim.opt.rtp:append(plugin.dir .. "/packages/neovim") -- for "aura-theme"
	vim.cmd.colorscheme("nordic")
	vim.opt.background = "dark"
	vim.g.moonflyItalics = false
	vim.cmd.highlight("Normal ctermbg=none guibg=none")
	vim.cmd.highlight("NormalNC ctermbg=none guibg=none")
end

return M
