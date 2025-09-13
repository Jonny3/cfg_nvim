local win_state = {
  [1] = {
    buf = -1,
    win = -1,
  },
}

local function open_floating_window(opts)
  opts = opts or {}
  local width = opts and opts.widh or math.floor(vim.o.columns * 0.8)
  local height = opts and opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- create buffer
  local buf = nil
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else -- create a scratch buffer
    buf = vim.api.nvim_create_buf(false, true)

    -- Exclude this new buffer from the buffer list
    vim.api.nvim_set_option_value('buflisted', false, { buf = buf })
  end

  -- create window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- return values as table
  return { buf = buf, win = win }
end

-- Call the function on startup -> just for documentation purposes
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     open_floating_window()
--   end,
-- })

-- toggle terminal
local toggle_terminal = function(opts)
  opts = opts or {}
  local index = opts and opts.fargs and tonumber(opts.fargs[1]) or 1

  if #win_state < index then
    local new_win_state = {
      buf = -1,
      win = -1,
    }
    table.insert(win_state, new_win_state)

    if index - #win_state == 1 then
      index = #win_state
    end
  end

  if not vim.api.nvim_win_is_valid(win_state[index].win) then
    win_state[index] = open_floating_window { buf = win_state[index].buf }
    if vim.bo[win_state[index].buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(win_state[index].win)
  end
end

-- create user command
vim.api.nvim_create_user_command('FloatTerminal', toggle_terminal, { nargs = 1, desc = 'Opens terminal with given index.' })

-- open floating terminal user shortcut
vim.keymap.set('n', '<leader>tt', toggle_terminal, { desc = 'toggle terminal' })
vim.keymap.set('n', '<leader>t1', function()
  toggle_terminal { fargs = { 1 } }
end, { desc = 'toggle terminal 1' })
vim.keymap.set('n', '<leader>t2', function()
  toggle_terminal { fargs = { 2 } }
end, { desc = 'toggle terminal 2' })
vim.keymap.set('n', '<leader>t3', function()
  toggle_terminal { fargs = { 3 } }
end, { desc = 'toggle terminal 3' })

-- test -> just for execution/testing, luafile ~/path/to/luafile
-- win_state.floating = open_floating_window()
-- print(vim.inspect(win_state.floating))
