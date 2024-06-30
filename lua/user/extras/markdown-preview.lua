local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- install without yarn or npm
  build = function() vim.fn["mkdp#util#install"]() end,
}

-- NOTE: check config here: https://github.com/iamcco/markdown-preview.nvim#markdownpreview-config

return M
