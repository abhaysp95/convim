local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup {
    default_file_explorer = true,
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      -- @param string name
      -- @param bufnr integer
      is_hidden_file = function(name, _)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      -- @param string name
      -- @param bufnr integer
      is_always_hidden = function(name, _)
        return name == ".." or name == ".git"
      end,
      -- Sort file names in a more intuitive order for humans. Is less performant,
      -- so you may want to set to false if you work with large directories.
      natural_order = true,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
    },
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = true,
    },
    float = {
      max_height = 35,
      max_width = 100,
    },
  }

end

return M
