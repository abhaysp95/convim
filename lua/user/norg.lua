local M = {
  "nvim-neorg/neorg",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
    }
  },
  -- tag = "*",
  lazy = true, -- enable lazy load
  ft = "norg", -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
}

function M.config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.concealer"] = {
        config = {
          icon_preset = "basic",  -- basic (default), diamond, varied
        },
      }, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            finance = "~/neorg/finance",
            personal = "~/neorg/personal_notes",
            work = "~/neorg/work",
            proj_ideas = "~/neorg/proj_ideas",
            quick_notes = "~/neorg/quick_notes",
            cp = "~/neorg/coding_problems",
          },
          default_workspace = "quick_notes",
        },
      },
    },
  }
end

return M
