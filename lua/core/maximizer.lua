local M = {}
local saved_layout = nil

function M.maximize()
    if saved_layout ~= nil then
        -- Already maximized, do nothing
        return
    end

    -- saved_layout = vim.fn.winsaveview() --TODO: not working
    saved_layout = vim.fn.winrestcmd()
    vim.cmd('vert resize | resize')
end

function M.restore()
    if saved_layout == nil then
        -- Nothing to restore
        return
    end

    -- vim.fn.winrestview(saved_layout) --TODO: not working
    vim.cmd(saved_layout)
    saved_layout = nil
end

function M.toggle()
    if saved_layout ~= nil then
        M.restore()
    elseif #vim.api.nvim_list_wins() > 1 then
        M.maximize()
    end
end

-- -- Load the maximizer module
local maximizer = M

-- Create a user command for the function
vim.api.nvim_create_user_command('MaximizerToggle', maximizer.toggle, { nargs = 0 })

-- Set a default keymap (for example, <F3>)
vim.keymap.set({ 'n', 'v', 'i' }, '<leader>wf', '<Cmd>MaximizerToggle<CR>', { desc = "Toggle buffer maximizer" })
