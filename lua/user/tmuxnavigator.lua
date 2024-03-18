local M = {
  "alexghergh/nvim-tmux-navigation"
}

function M.config()
  require('nvim-tmux-navigation').setup {
    disable_when_zoomed = false
  }
end

return M
