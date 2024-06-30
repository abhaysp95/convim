local M = {
  "Maan2003/lsp_lines.nvim",
  -- how to use url with Lazy ?
  -- { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }

}

function M.config()
  require('lsp_lines').setup()

  -- NOTE: use the below keymap when you don't want the virtual_text to be disabled permanently
  -- which is done in lspconfig file
  -- TODO: this is not good
  -- set this to false, if virtual_text is enabled at the start of nvim
  local lines_enabled = true
  vim.keymap.set('n', '<Leader>lL', function()
    lines_enabled = not lines_enabled
    vim.diagnostic.config({
      vitual_lines = lines_enabled, virtual_text = not lines_enabled
    })
  end)

end

return M
