local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>tT",
      "<cmd>Trouble diagnostics toggle<CR>",
      desc = "Diagnostics (Trouble)",
    },{
      "<leader>ttT",  -- TODO: confirm if this is for current buf or all bufs
      "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Diagnostics current buf (Trouble)",
    },{
      "<leader>ttS",
      "<cmd>Trouble symbols toggle focus=false<CR>",
      desc = "Diagnostics (Trouble)",
    }
  }
}


return M
