local M = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
}

function M.config()
  local tt = require("toggleterm")
  tt.setup({
    shading_factor = "0", -- TODO: check this out
    hide_numbers = false,
    direction = "float",
    start_in_insert = true,
    persist_mode = false,
    on_open = function(_)
      vim.opt_local.relativenumber = true,
      -- TODO: understand more about callback below
      vim.fn.timer_start(1, function()
        vim.cmd('startinsert!')
      end)
    end,
    -- TODO: useful in gui part, check what difference it makes with default value
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.5
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
  })

  local ttt = require("toggleterm.terminal")
  local term = ttt.Terminal
  vim.keymap.set("n", "<m-g>", function()
    local t = term:new({
      cmd = "lazygit",
      display_name = "lazygit",
    })
    t:toggle()  -- open the terminal
  end, { desc = "open lazygit"})

  vim.keymap.set({"n", "t"}, "<m-->", function()
    local t = term:new({
      display_name = "dash terminal",
      direction = "horizontal",
    })
    print("set dir: ", t.direction)
    t:toggle()
  end, { desc = "open terminal horizontally"})
  vim.keymap.set("n", [[<m-|>]], function()
    local t = term:new({
      display_name = "pipe terminal",
      direction = "vertical",
    })
    t:toggle()  -- open the terminal
  end, { desc = "open terminal vertically"})
  -- NOTE: I can write to toggle in float the same way as above, but then when rotating through terminal,
  -- horizontal one can open in vertical, vertical in float etc.
  -- and this will disrupt the texts present on respective terminal's screens


  local function get_term_index(current_id, terms)
    local idx 
    for i, v in ipairs(terms) do
      if  v.id == current_id then
        idx = i
      end
    end
    return idx
  end

  local function goto_prev_term()
    local current_id = vim.b.toggle_number
    if current_id == nil then
      return
    end
    local terms = ttt.get_all(true)
    local prev_index
    local index = get_term_index(current_id, terms)
    if index > 1 then
      prev_index = index - 1
    else
      prev_index = #terms
    end
    tt.toggle(terms[index].id)
    tt.toggle(terms[prev_index].id)
  end

  local function goto_next_term()
    local current_id = vim.b.toggle_number
    if current_id == nil then
      return
    end
    local terms = ttt.get_all(true)
    local next_index
    local index = get_term_index(current_id, terms)
    if index < #terms then
      next_index = index + 1
    else
      next_index = 1
    end
    tt.toggle(terms[index].id)
    tt.toggle(terms[next_index].id)
  end

  -- TODO: add toggleterm_manager plugin
  vim.keymap.set({"n", "t"}, "<F6>", "<cmd>Telescope toggleterm_manager<CR>", {desc = "Search terminal in telescope"})
  vim.keymap.set({"n", "t"}, "<m-t>", [[<cmd>exe v:count1 . "ToggleTerm"<CR>]], {desc = "Toggle terminal"})
  vim.keymap.set({"n", "t"}, "<F8>", function()
    goto_next_term()
  end, {desc = "Toggle terminal"})
  vim.keymap.set({"n", "t"}, "<F7>", function()
    goto_prev_term()
  end, {desc = "Toggle terminal"})

  vim.cmd[[
    augroup terminal_setup | au!
    autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
    autocmd TermEnter * startinsert!
    augroup end
  ]]

  vim.api.nvim_create_autocmd({ "TermEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.cmd "startinsert"
      _G.set_terminal_keymaps()
    end,
  })

  local opts = { noremap = true, silent = true }
  -- resize the terminal efficiently
  function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
  end

end

return M
