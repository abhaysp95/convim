local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}


function M.config()
  local servers = {
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "solc",
    "pyright",
    "rust_analyzer",
    "tsserver",
    "zls",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
