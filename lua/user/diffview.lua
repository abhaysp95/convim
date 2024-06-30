local M = {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
}

function M.config()
  vim.opt.fillchars:append { diff = "/" }
end

return M

-- NOTE: read the example here: https://github.com/sindrets/diffview.nvim
--       read about default config here: https://github.com/sindrets/diffview.nvim?tab=readme-ov-file#configuration
