--
--
--         ▀▀█                    ▀                  █        ▀               █    ▀
--  ▄▄▄▄     █    ▄   ▄   ▄▄▄▄  ▄▄▄    ▄ ▄▄          █▄▄▄   ▄▄▄    ▄ ▄▄    ▄▄▄█  ▄▄▄    ▄ ▄▄    ▄▄▄▄   ▄▄▄
--  █▀ ▀█    █    █   █  █▀ ▀█    █    █▀  █         █▀ ▀█    █    █▀  █  █▀ ▀█    █    █▀  █  █▀ ▀█  █   ▀
--  █   █    █    █   █  █   █    █    █   █   ▀▀▀   █   █    █    █   █  █   █    █    █   █  █   █   ▀▀▀▄
--  ██▄█▀    ▀▄▄  ▀▄▄▀█  ▀█▄▀█  ▄▄█▄▄  █   █         ██▄█▀  ▄▄█▄▄  █   █  ▀█▄██  ▄▄█▄▄  █   █  ▀█▄▀█  ▀▄▄▄▀
--  █                     ▄  █                                                                  ▄  █
--  ▀                      ▀▀                                                                    ▀▀
--
--  => lua/plugins/plugin_keybindings.lua


-- NOTE: <Leader> is behaving for <Localleader>, figure out the issue

local default_opts = { noremap = true, silent = true }

-- short function alias
local keybind = vim.api.nvim_set_keymap

------------------------
-- vim-tmux-navigator --
------------------------
-- I'm already habitual to default bindings of plugin
keybind('n' , '<C-h>'  , ':NvimTmuxNavigateLeft<CR>'     , default_opts)
keybind('n' , '<C-j>'  , ':NvimTmuxNavigateDown<CR>'     , default_opts)
keybind('n' , '<C-k>'  , ':NvimTmuxNavigateUp<CR>'       , default_opts)
keybind('n' , '<C-l>'  , ':NvimTmuxNavigateRight<CR>'    , default_opts)
keybind('n' , '<C-->' , ':NvimTmuxNavigatePrevious<CR>' , default_opts)

---------------
-- nvim_tree --
---------------
keybind('n' , '<C-n>'      , ':NvimTreeToggle<CR>'   , default_opts)
keybind('n' , '<Space>nr' , ':NvimTreeRefresh<CR>'  , default_opts)
keybind('n' , '<Space>nf' , ':NvimTreeFindFile<CR>' , default_opts)

--------------
-- gitsigns --
--------------
keybind('n', ']c', '<cmd>lua require"gitsigns".next_hunk()<CR>', default_opts)
keybind('n', '[c', '<cmd>lua require"gitsigns".prev_hunk()<CR>', default_opts)
keybind('n', '<Space>hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', default_opts)
keybind('n', '<Space>hS', '<cmd>lua require"gitsigns".stage_buffer()<CR>', default_opts)
keybind('n', '<Space>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', default_opts)
keybind('n', '<Space>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', default_opts)
keybind('n', '<Space>hR', '<cmd>lua require"gitsigns".reset_buffer()<CR>', default_opts)
keybind('n', '<Space>hU', '<cmd>lua require"gitsigns".reset_buffer_index()<CR>', default_opts)
keybind('n', '<Space>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', default_opts)
keybind('n', '<Space>hb', '<cmd>lua require"gitsigns".blame_line{full=true}()<CR>', default_opts)
keybind('n', '<Space>hd', '<cmd>lua require"gitsigns".diffthis()<CR>', default_opts)
keybind('n', '<Space>hD', '<cmd>lua require"gitsigns".diffthis ~<CR>', default_opts)
keybind('n', '<Space>ht', '<cmd>lua require"gitsigns".toggle_deleted()<CR>', default_opts)

------------
-- neogit --
------------
keybind("n", "<leader>ng", ":Neogit<CR>", default_opts)

------------
-- gitlink --
------------
keybind("n", "<leader>hg", "<cmd>GitLink<CR>", default_opts)
keybind("n", "<leader>hG", "<cmd>GitLink blame<CR>", default_opts)

--------------------
-- nvim-telescope --
--------------------
keybind('n', '<Leader>tS', [[:lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>]], default_opts)
keybind('n', '<Leader>tf', [[:lua require('telescope.builtin').find_files()<CR>]], default_opts)
keybind('n', '<Leader>tl', [[:lua require('telescope.builtin').live_grep()<CR>]], default_opts)
keybind('n', '<Leader>tl', [[:lua require('telescope.builtin').resume()<CR>]], default_opts)
keybind('n', '<Leader>tw', [[:lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]], default_opts)
keybind('n', '<Leader>tb', [[:lua require('telescope.builtin').buffers()<CR>]], default_opts)
keybind('n', '<Leader>th', [[:lua require('telescope.builtin').help_tags()<CR>]], default_opts)
keybind('n', '<Leader>tC', [[:lua require('telescope.builtin').colorscheme()<CR>]], default_opts)
keybind('n', '<Leader>td', [[:lua require('telescope.builtin').search_dotfiles()<CR>]], default_opts)
keybind('n', '<Leader>tg', [[:lua require('telescope.builtin').git_files()<CR>]], default_opts)
keybind('n', '<Leader>tG', [[:lua require('telescope.builtin').git_branches()<CR>]], default_opts)
keybind('n', '<Leader>tc', [[:lua require('telescope.builtin').git_commits()<CR>]], default_opts)
keybind('n', '<Leader>ts', [[:lua require('telescope.builtin').git_stash()<CR>]], default_opts)
keybind('n', '<Leader>tr', [[:lua require('telescope.builtin').resume()<CR>]], default_opts)

-------------
-- lspsaga --
-------------
-- keybind('n' , '<Leader>gJ' , ':Lspsaga diagnostic_jump_next<CR>', default_opts)
-- keybind('n' , 'K'          , ':Lspsaga hover_doc<CR>', default_opts)
-- keybind('i' , '<Leader>gk'         , ':Lspsaga signature_help<CR>', default_opts)
-- keybind('n' , '<Leader>gh' , ':Lspsaga lsp_finder<CR>', default_opts)
-- keybind('n' , '<Leader>ga' , ':Lspsaga code_action<CR>', default_opts)
-- keybind('v' , '<Leader>ga' , ':<C-U>Lspsaga range_code_action<CR>', default_opts)
-- keybind('n' , '<C-f>'      , [[<cmd>lua require('lspsaga.action') .smart_scroll_with_saga(1) <CR>]], default_opts)
-- keybind('n' , '<C-b>'      , [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1) <CR>]], default_opts)
-- keybind('n' , '<Leader>gr' , [[<cmd>lua require('lspsaga.rename').rename() <CR>]], default_opts)
-- keybind('n' , '<Leader>gp' , [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], default_opts)
-- keybind('n' , '<Leader>fl' , [[<cmd>lua require('lspsaga.floaterm').open_float_terminal() <CR>]], default_opts)
-- keybind('n' , '<Leader>fz' , [[<cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>]], default_opts)
-- keybind('t' , '<Leader>fl' , [[<C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]], default_opts)


--------------
-- floaterm --
--------------
-- vim.cmd("let g:floaterm_keymap_new = '<leader>tn'")
-- vim.cmd("let g:floaterm_keymap_toggle = '<leader>tl'")
-- vim.cmd("let g:floaterm_keymap_prev = '<leader>tj'")
-- vim.cmd("let g:floaterm_keymap_next = '<leader>tk'")
-- keybind('n', '<Leader>tn', ':FloatermNew<CR>', default_opts)
-- keybind('n', '<Leader>tl', ':FloatermToggle<CR>', default_opts)
-- keybind('n', '<Leader>tj', ':FloatermPrev<CR>', default_opts)
-- keybind('n', '<Leader>tk', ':FloatermNext<CR>', default_opts)

----------------
-- kommentary --
----------------

-- extended mappings (default are the same)
keybind("n", "<leader>ckc", "<Plug>kommentary_line_increase", default_opts)
keybind("n", "<leader>ck", "<Plug>kommentary_motion_increase", default_opts)
keybind("x", "<leader>ck", "<Plug>kommentary_visual_increase", default_opts)
keybind("n", "<leader>cjc", "<Plug>kommentary_line_decrease", default_opts)
keybind("n", "<leader>cj", "<Plug>kommentary_motion_decrease", default_opts)
keybind("x", "<leader>cj", "<Plug>kommentary_visual_decrease", default_opts)

--[[ uncomment & change, when you want to use custom bindings (set in config
lua/plugins/kommentary.lua) ]]
--[[
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})
--]]

--------------
-- diffview --
--------------
keybind("n", "<leader>do", ":DiffviewOpen<CR>", default_opts)
keybind("n", "<leader>dO", ":DiffviewOpen ", default_opts)
keybind("n", "<leader>dC", ":DiffviewClose<CR>", default_opts)
keybind("n", "<leader>dh", ":DiffviewFileHistory<CR>", default_opts)
keybind("n", "<leader>dF", ":DiffviewFocusFiles<CR>", default_opts)
keybind("n", "<leader>dR", ":DiffviewRefresh<CR>", default_opts)

-----------
-- noice --
-----------

keybind("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", default_opts)

---------
-- oil --
---------
keybind("n", "+", "<CMD>Oil --float<CR>", default_opts)

-- NOTE: keybindings for lspconfig are in lsp/init.lua
