local M = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
}

function M.config()
  local tt = require("toggleterm")
  tt.setup({
    shading_factor = "-15", -- TODO: check this out
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

  vim.keymap.set({"n", "t"}, "<m-g>", function()
    local terms = ttt.get_all();  -- get non-hidden terms
    for _, v in ipairs(terms) do
      print("direction: ", v.direction)
      if v.display_name == "lazygit" then
        v:toggle()
        return
      end
    end
    local t = term:new({
      cmd = "lazygit",
      display_name = "lazygit",
    })
    t:toggle()  -- open the terminal
  end, { desc = "open lazygit"})

  -- TODO: remote <m-t> keybinding, it'll always open terminal with id 1, whichever direction it'll be
  -- TODO: add a new callback which would get the direction of current open terminal
  -- upon which keybinding is invoked and will hide it
  -- TODO: current keymaps for opening in different directions shouldn't handle the toggling logic
  -- but open the existing terminal or new terminal by doing <count><their keymap>

  -- hide the current focused terminal irrespective of which directions it is
  vim.keymap.set({"n", "t"}, "<m-.>", function()
    local current_idx = vim.b.toggle_number
    if current_idx == nil then
      return
    end
    local terms = ttt.get_all()
    local current_id = get_term_index(current_idx, terms)
    tt.toggle(terms[current_id].id)
  end, {desc = "hide the open terminal"})

  -- open the new terminal and open another new terminal 
  -- if hidden you should open existing terminal first and then you can open new one again.

  -- NOTE: right now, these keybindings will open at max two terminals in each direction
  -- if no terminal is open, open a new one
  -- if a terminal is spawned and hidden, open the existing one
  -- if a terminal is open, open another one
  -- if two terminals are spawned and hidden, open first one for the direction to which key you pressed
  -- if two terminals are spawned and one is open, toggle to another one

  -- NOTE: I don't think we should need more than two terminal at a time for any direction
  -- but if we want, then I guess I have to split keybinding in new functionality
  -- that is, one to open the first exising one if hidden, or open a new one if one is already visible
  -- another to open a new one if irrespective of any terminal in same direction is hidden or not

  -- opens terminal horizontally
  vim.keymap.set("n", "<m-->", function()
    local terms = ttt.get_all();  -- get non-hidden terms
    for _, v in ipairs(terms) do
      print("direction: ", v.direction)
      if v.direction == "horizontal" and v:is_open() == false then
        v:open()
        return
      end
    end
    local t = term:new({
      display_name = "dash terminal",
      direction = "horizontal",
    })
    print("set dir: ", t.direction)
    t:toggle()
  end, { desc = "open terminal horizontally"})

  -- open terminal vertically
  vim.keymap.set("n", [[<m-|>]], function()
    local terms = ttt.get_all()
    for _, v in ipairs(terms) do
      if v.direction == "vertical" and v:is_open() == false then
        v:open()
        return
      end
    end
    local t = term:new({
      display_name = "pipe terminal",
      direction = "vertical",
    })
    t:toggle()  -- open the terminal
  end, { desc = "open terminal vertically"})

  -- open terminal in float
  vim.keymap.set({"n", "t"}, "<m-t>", function()
    local terms = ttt.get_all()
    for _, v in ipairs(terms) do
      if v.direction == "float" and v:is_open() == false then
        v:open()
        return
      end
    end
    local t = term:new({
      display_name = "float terminal",
      direction = "float",
    })
    t:toggle()  -- open the terminal
  end, { desc = "open terminal vertically"})

  -- TODO: add toggleterm_manager plugin
  vim.keymap.set({"n", "t"}, "<F6>", "<cmd>Telescope toggleterm_manager<CR>", {desc = "Search terminal in telescope"})
  -- vim.keymap.set({"n", "t"}, "<m-t>", [[<cmd>exe v:count1 . "ToggleTerm"<CR>]], {desc = "Toggle terminal"})
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
