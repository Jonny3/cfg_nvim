local win_state = {
  floating = {
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

-- Call the function on startup
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     open_floating_window()
--   end,
-- })

-- toggle terminal
local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(win_state.floating.win) then
    win_state.floating = open_floating_window { buf = win_state.floating.buf }
    if vim.bo[win_state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(win_state.floating.win)
  end
end

-- create user command
vim.api.nvim_create_user_command('FloatTerminal', toggle_terminal, {})

-- open floating terminal user shortcut
vim.keymap.set('n', '<leader>tt', toggle_terminal, { desc = 'toggle terminal' })

-- test -> just for execution/testing, luafile
-- win_state.floating = open_floating_window()
-- print(vim.inspect(win_state.floating))
