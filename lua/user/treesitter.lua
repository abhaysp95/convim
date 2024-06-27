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

local ensure_installed;
if Architecture ~= "aarch64 Android" then
  ensure_installed = {
    "angular", "asm", "awk", "bash", "bibtex", "c", "cpp", "clojure", "cmake",
    "elixir", "elm", "erlang", "go", "haskell", "html", "java", "javascript", "json",
    "kotlin", "latex", "lua", "make", "markdown", "markdown_inline", "meson", "nim",
    "norg", "ocaml", "perl", "python", "proto", "rust", "ruby", "scala", "solidity", "sql",
    "typescript", "zig"
  }
else
  ensure_installed = { "c", "bash", "markdown", "markdown_inline", "vimdoc" }
end

function M.config()
  require('ts_context_commentstring').setup {
    enable = true,
    enable_autocmd = false,
    -- languages = {
    --   typescript = '// %s',
    -- },
  }
  require("nvim-treesitter.configs").setup {
    highlight = {
      enable = true,
      disable = { "markdown" },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autotag = { enable = true },
    autopairs = { enable = true },
    ensure_installed = ensure_installed,
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
