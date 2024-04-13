local M = {
  "mbbill/undotree",
}


function M.config()
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  vim.g.undotree_WindowLayout = 3
end

return M
