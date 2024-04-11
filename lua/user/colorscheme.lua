local M = {
  -- "LunarVim/darkplus.nvim",
	-- 'ChristianChiarulli/nvcode-color-schemes.vim',
	-- 'savq/melange-nvim',
  -- 'folke/tokyonight.nvim',
  'RRethy/base16-nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  vim.cmd.colorscheme "base16-greenscreen"
  vim.opt.background = 'dark'
end

return M
