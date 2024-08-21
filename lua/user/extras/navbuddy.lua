local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  -- local wk = require "which-key"
  -- wk.register {
  --   ["<leader>o"] = { "<cmd>Navbuddy<cr>", "Nav" },
  -- }

  local navbuddy = require "nvim-navbuddy"
  -- local actions = require("nvim-navbuddy.actions")
  navbuddy.setup {
    window = {
      border = "single",
      size = { height = "75%", width = "90%"},
			sections = {
				left = {
					size = "20%",
					border = nil, -- You can set border style for each section individually as well.
				},
				mid = {
					size = "30%",
					border = "solid",
				},
				right = {
					-- No size option for right most section. It fills to
					-- remaining area.
					border = nil,
					preview = "always",  -- Right section can show previews too.
									   -- Options: "leaf", "always" or "never"
				}
			}
    },
    icons = require("user.icons").kind,
    lsp = { auto_attach = true },
  }

  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_set_keymap

  keymap("n", "<m-o>", ":silent only | Navbuddy<cr>", opts)
end

return M
