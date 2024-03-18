--
--  █
--  █   ▄   ▄▄▄   ▄   ▄  ▄▄▄▄▄   ▄▄▄   ▄▄▄▄    ▄▄▄
--  █ ▄▀   █▀  █  ▀▄ ▄▀  █ █ █  ▀   █  █▀ ▀█  █   ▀
--  █▀█    █▀▀▀▀   █▄█   █ █ █  ▄▀▀▀█  █   █   ▀▀▀▄
--  █  ▀▄  ▀█▄▄▀   ▀█    █ █ █  ▀▄▄▀█  ██▄█▀  ▀▄▄▄▀
--                 ▄▀                  █
--
--  => lua/user/keymaps.lua

local term_opts = { silent = true }
local expr_opts = { expr = true }
local default_opts = { noremap = true, silent = true }
-- local def_expr_opts = { noremap = true, silent = true, expr = true }

-- shorten the function name
local keybind = vim.keymap.set

-- setup for leader key
keybind('', '<Space>', '<NOP>', default_opts)
vim.g.mapleader = " "
-- print(vim.inspect(vim.g.mapleader))

-- setup for localleader key
keybind('', [[\]], '<NOP>', default_opts)
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- reset search highlight
keybind('n', '<M-;>', ':nohlsearch<CR>', default_opts)

-- for list chars
keybind('n', '<Leader>il', ':setlocal list!<CR>:setlocal list?<CR>', default_opts)

-- replacement of words
-- press * then press a mapping below to replace all instances
--
-- put * and vim-visual-start-search
--
--

-- keep cursor at the bottom of the visual selection after you yank it
keybind('v', 'y', 'ygv<Esc>', default_opts)
keybind('v', 'y', 'y`]', default_opts)
keybind('n', 'p', 'p`]', default_opts)
keybind('n', 'p', 'p`]', default_opts)

-- repeat replacement
keybind('n', '<Leader>s*', [[:let@/='\<'.expand('<cword>').'\>'<CR>cgn]], default_opts)
keybind('x', '<Leader>s*', 'sy:let @/=@s<CR>cgn', default_opts)

-- press enter for newline without insert
keybind('n', '<M-CR>', 'o<Esc>', default_opts)
keybind('n', '<Localleader><CR>', 'O<Esc>', default_opts)
keybind('n', '<Localleader>x', 'i<Space><Esc>l', default_opts)
keybind('n', '<Localleader>g<CR>', 'r<CR>kddpk', default_opts)
keybind('n', '<Localleader><Localleader>g<CR>', 'i<CR><Esc>kddpk', default_opts)
keybind('n', '<M-P>', 'I<Space><Esc>pmp0x`p', default_opts)

-- format paragraph (think some small binding, or don't use at all)
keybind('n', '<Leader>gP', 'gqap', default_opts)
keybind('n', '<Leader>gP', 'gqa', default_opts)

-- line-numbers settings
keybind('n', '<F5>', ':set invrelativenumber invnumber<CR>', default_opts)
keybind('n', '<Leader>N', ':set nonumber norelativenumber<CR>', default_opts)

-- spell-check('o' for 'orthography')
keybind('n', '<F6>', ':setlocal spell! spelllang=en_us<CR>', default_opts)
keybind('n', '<Leader>ic', ':set noic<CR>', default_opts)

-- movement in insert mode
keybind('i', '<M-h>', '<Left>', default_opts)
keybind('i', '<M-k>', '<Up>', default_opts)
keybind('i', '<M-l>', '<Right>', default_opts)
keybind('i', '<M-j>', '<Down>', default_opts)
keybind('s', '<M-h>', '<Left>', default_opts)
keybind('s', '<M-k>', '<Up>', default_opts)
keybind('s', '<M-l>', '<Right>', default_opts)
keybind('s', '<M-j>', '<Down>', default_opts)

-- useful for errors
keybind('n', 'cln', ':lnext<CR>', default_opts)
keybind('n', 'clp', ':lprevious<CR>', default_opts)
keybind('n', 'clc', ':lclose<CR>', default_opts)
keybind('n', 'clo', ':lopen<CR>', default_opts)
keybind('n', 'ccn', ':cnext<CR>', default_opts)
keybind('n', 'ccp', ':cprevious<CR>', default_opts)
keybind('n', 'ccc', ':cclose<CR>', default_opts)
keybind('n', 'cco', ':copen<CR>', default_opts)

-- better indenting
-- keybind('n', '<', '<gv', default_opts)
-- keybind('n', '>', '>gv', default_opts)

-- move selected line/bloc in visual mode
keybind('x', 'K', [[:move '<-2<CR>gv-gv']], default_opts)
keybind('x', 'J', [[move '>+1<CR>gv-gv']], default_opts)

-- default trees
keybind('n', '<Leader>nl', ':Lex! | vertical resize 30<CR>', default_opts)

-- move between buffers
-- cycle between previous buffer
keybind('n', '<M-TAB>', ':b#<CR>', default_opts)
keybind('n', '<M-b>', ':bnext<CR>', default_opts)
keybind('n', '<M-B>', ':bprev<CR>', default_opts)

-- select full file
keybind('n', 'gG', 'gg0vG$', default_opts)

-- repeat command mode last command
keybind('n', 'g.', '@:', default_opts)

-- get pwd
keybind('n', 'cd', ':cd %:p:h<CR>', default_opts)

-- back a directory
keybind('n', 'cu', ':cd ..<CR>', default_opts)

-- force close all files
keybind('n', 'zq', ':qa!<CR>', default_opts)

-- replace with dashes
keybind('n', '<Localleader>-', 'YpVr-', default_opts)
keybind('n', '<Localleader>_', 'YPVr-', default_opts)

-- enable/disable auto-comments character
keybind('n', '<Leader>cd', ':setlocal formatoptions-=cro<CR>', default_opts)
keybind('n', '<Leader>ce', ':setlocal formatoptions+=cro<CR>', default_opts)

-- file checking with shellcheck
keybind('n', '<Leader>S', ':!clear && shellcheck %<CR>', default_opts)

-- save file as sudo
keybind('c', 'w!!', 'w !sudo tee > /dev/null %', term_opts)

-- copy paste registers
keybind('n', '<Leader>y', '"*y', default_opts)
keybind('n', '<Leader>p', '"*p', default_opts)
keybind('n', '<Leader>Y', '"+y', default_opts)
keybind('n', '<Leader>P', '"+p', default_opts)

-- delete all buffers except current one
keybind('n', '<Leader>bd', ':silent :w | %bd | e#<CR>', default_opts)

-- cycle through splits
keybind('n', '<C-TAB>', '<C-w>w', default_opts)

-- better navigation between windows
keybind('n', '<C-h>', '<C-w>h>', default_opts)
keybind('n', '<C-j>', '<C-w>j>', default_opts)
keybind('n', '<C-k>', '<C-w>k>', default_opts)
keybind('n', '<C-l>', '<C-w>l>', default_opts)

-- window resizing
keybind('n', '<M-h>', ':vertical resize -2<CR>', default_opts)
keybind('n', '<M-k>', ':resize +2<CR>', default_opts)
keybind('n', '<M-l>', ':vertical resize +2<CR>', default_opts)
keybind('n', '<M-j>', ':resize -2<CR>', default_opts)

-- change split orientation
keybind('n', '<Localleader>th', '<C-w>t<C-w>H', default_opts)
keybind('n', '<Localleader>tk', '<C-w>t<C-w>K', default_opts)

-- tab bindings
keybind('n', '<Localleader>gd', ':tabclose<CR>', default_opts)

-- some expand settings
keybind('n', '<Leader>hw', [[:h <C-R>=expand('<cword>')<CR><CR>]], default_opts)

-- misc
keybind('i', 'j\'', '<Esc>', default_opts)
keybind('n', 'c', '"_c', default_opts)

-- TAB completion (seems problematic)
keybind('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], vim.tbl_extend("force", expr_opts, default_opts))

-- move to <++>
keybind('n', '<Leader><', '/<++><CR>ca<', default_opts)

vim.cmd [[ autocmd FileType help nnoremap <buffer>q :helpclose<CR> ]]

keybind("n", "<C-i>", "<C-i>", default_opts)

keybind("n", "n", "nzz", default_opts)
keybind("n", "N", "Nzz", default_opts)
keybind("n", "*", "*zz", default_opts)
keybind("n", "#", "#zz", default_opts)
keybind("n", "g*", "g*zz", default_opts)
keybind("n", "g#", "g#zz", default_opts)

-- Stay in indent mode
keybind("v", "<", "<gv", default_opts)
keybind("v", ">", ">gv", default_opts)

keybind("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
-- keybind({ "n", "o", "x" }, "<s-h>", "^", default_opts)
-- keybind({ "n", "o", "x" }, "<s-l>", "g_", default_opts)

-- tailwind bearable to work with
-- keybind({ "n", "x" }, "j", "gj", default_opts)
-- keybind({ "n", "x" }, "k", "gk", default_opts)
-- keybind("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", default_opts)


vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', default_opts)


-- Thoughts:  consider making function instead of writing every line, check if making a function and calling is worth it or not
-- put up terminal window naviagation <C-\><C-N>
