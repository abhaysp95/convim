--
--                  ▀                    ▄                                  ▀      ▄      ▄
--  ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄         ▄▄█▄▄   ▄ ▄▄   ▄▄▄    ▄▄▄    ▄▄▄   ▄▄▄    ▄▄█▄▄  ▄▄█▄▄   ▄▄▄    ▄ ▄▄
--  █▀  █  ▀▄ ▄▀    █    █ █ █           █     █▀  ▀ █▀  █  █▀  █  █   ▀    █      █      █    █▀  █   █▀  ▀
--  █   █   █▄█     █    █ █ █   ▀▀▀     █     █     █▀▀▀▀  █▀▀▀▀   ▀▀▀▄    █      █      █    █▀▀▀▀   █
--  █   █    █    ▄▄█▄▄  █ █ █           ▀▄▄   █     ▀█▄▄▀  ▀█▄▄▀  ▀▄▄▄▀  ▄▄█▄▄    ▀▄▄    ▀▄▄  ▀█▄▄▀   █
--
--
--  => lua/plugins/nvim-treesitter.lua

local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" },
    highlight = {
      enable = true,
      disable = { "markdown" },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autotag = { enable = true },
    autopairs = { enable = true },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    ensure_installed = {
      "angular", "asm", "awk", "bash", "bibtex", "c", "cpp", "clojure", "cmake",
      "elixir", "elm", "erlang", "go", "haskell", "html", "java", "javascript", "json",
      "kotlin", "latex", "lua", "make", "markdown", "markdown_inline", "meson", "nim",
      "ocaml", "perl", "python", "proto", "rust", "ruby", "scala", "solidity", "sql",
      "typescript", "zig"
    },
    ignore_instal = {},  -- ignore parsers
    incremental_selection = {
      enable = true,
      keymap = {
        init_selection = "gnn",
        node_incremental = "gnn",
        scope_incremental = "gnc",
        node_decremental = "gnd",
      },
    },
  }
end

return M
