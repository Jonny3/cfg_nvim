return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
    -- 'mrcjkb/rustaceanvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup()
    -- installing debugpy via mason
    local pypath = vim.fn.expand '$MASON/packages/debugpy/venv/bin/python'
    require('dap-python').setup(pypath)

    -- adding codelldb as debuger option
    local codelldb_path = vim.fn.expand '$MASON/packages/codelldb/extension/adapter/codelldb'
    local liblldb_path = vim.fn.expand '$MASON/packages/codelldb/extension/lldb/lib/libdllb.so'

    dap.adapters.codelldb = {
      type = 'executable',
      command = codelldb_path,
    }

    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- reading dap_launch.json to load debug configuration
    -- require('dap.ext.vscode')._load_json '~/programming/dap_launch.json'

    vim.api.nvim_set_hl(0, 'DapBreakpointSymbol', { fg = '#FF0000', bg = 'NONE', bold = true }) -- Bright Red
    vim.api.nvim_set_hl(0, 'DapStoppedLineSymbol', { fg = '#00FF00', bg = 'NONE', bold = true }) -- Bright Green
    vim.api.nvim_set_hl(0, 'DapBreakpointLine', { bg = '#440000' }) -- Darker red background for the line
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#004400' }) -- Darker green background for the stopped line

    vim.fn.sign_define('DapBreakpoint', {
      text = '⚡️',
      texthl = 'DapBreakpointSymbol',
      linehl = 'DapBreakpointLine',
      numhl = 'DapBreakpointSymbol',
    })
    -- Define the stopped line sign (where the debugger is currently paused)
    vim.fn.sign_define('DapStopped', {
      text = '▶', -- A clear play symbol emoji
      texthl = 'DapStoppedLineSymbol',
      linehl = 'DapStoppedLine',
      numhl = 'DapStoppedLineSymbol',
    })

    -- Optional: Define conditional breakpoint and logpoint signs as well
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '🚧', -- Construction emoji for conditional
      texthl = 'DapBreakpointSymbol',
      linehl = 'DapBreakpointLine',
      numhl = 'DapBreakpointSymbol',
    })

    vim.fn.sign_define('DapLogPoint', {
      text = '📝', -- Memo emoji for logpoint
      texthl = 'DapStoppedLineSymbol', -- Can reuse a highlight or create new
      linehl = 'DapStoppedLine',
      numhl = 'DapStoppedLineSymbol',
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<F5>', function()
      dap.continue()
    end, { desc = 'continue' })
    vim.keymap.set('n', '<F10>', function()
      dap.step_over()
    end, { desc = 'step_over' })
    vim.keymap.set('n', '<F11>', function()
      dap.step_into()
    end, { desc = 'step_into' })
    vim.keymap.set('n', '<F12>', function()
      dap.step_out()
    end, { desc = 'step_out' })
    vim.keymap.set('n', '<Leader>dt', function()
      dap.toggle_breakpoint()
    end, { desc = 'toggle breakpoint' })
    vim.keymap.set('n', '<Leader>dT', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'set conditional breakpoint' })
    vim.keymap.set('n', '<Leader>dp', function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = 'set breakpoint log message' })
    vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
      if vim.fn.mode() == 'n' then
        local line_content = vim.api.nvim_get_current_line()
        if line_content ~= '' then
          require('dapui').eval(line_content, { enter = true, width = 80, height = 40, context = '' })
        end
      else
        require('dapui').eval(nil, { enter = true, width = 80, height = 40, context = '' })
      end
    end, { desc = 'evaluate highlighted expression' })
  end,
}
