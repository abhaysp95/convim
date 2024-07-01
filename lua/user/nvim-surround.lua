local M = {
  "kylechui/nvim-surround",
  version = "*",  -- Use for stability; omit to use 'main' branch for latest features
  event = "VeryLazy",
}

function M.config()
  require("nvim-surround").setup({
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "<localleader>ys",
      normal_cur = "<localleader>yss",
      normal_line = "<localleader>yS",
      normal_cur_line = "<localleader>ySS",
      visual = "<localleader>S",
      visual_line = "<localleader>gS",
      delete = "<localleader>ds",
      change = "<localleader>cs",
      change_line = "<localleader>cS",
    },
  })
end

return M;
