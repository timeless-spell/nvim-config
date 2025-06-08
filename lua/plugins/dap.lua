local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'mfussenegger/nvim-dap',
    depends = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
  })

  local dap, dapui = require ('dap'), require ('dapui')
  local dap_virtual_text = require ('nvim-dap-virtual-text')

  dapui.setup ()
  dap_virtual_text.setup ()

  -- Change breakpoint icons
  vim.api.nvim_set_hl (0, 'DapBreak', { fg = '#e51400' })
  vim.api.nvim_set_hl (0, 'DapStop', { fg = '#ffcc00' })
  local breakpoint_icons = vim.g.have_nerd_font
      and {
        Breakpoint = '',
        BreakpointCondition = '',
        BreakpointRejected = '',
        LogPoint = '',
        Stopped = '',
      }
    or {
      Breakpoint = '●',
      BreakpointCondition = '⊜',
      BreakpointRejected = '⊘',
      LogPoint = '◆',
      Stopped = '⭔',
    }
  for type, icon in pairs (breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define (tp, { text = icon, texthl = hl, numhl = hl })
  end

  dap.listeners.before.attach.dapui_config = function ()
    dapui.open ()
  end
  dap.listeners.before.launch.dapui_config = function ()
    dapui.open ()
  end
  dap.listeners.before.event_terminated.dapui_config = function ()
    dapui.close ()
  end
  dap.listeners.before.event_exited.dapui_config = function ()
    dapui.close ()
  end

  dap.adapters.local_lua = {
    type = 'executable',
    command = 'node',
    args = {
      -- vim.env.HOME .. '/local/local-lua-debugger-vscode/extension/debugAdapter.js',
    },
    enrich_config = function (config, on_config)
      if not config['extensionPath'] then
        local c = vim.deepcopy (config)
        c.extensionPath = vim.env.HOME .. '/local/local-lua-debugger-vscode'
        on_config (c)
      else
        on_config (config)
      end
    end,
  }

  dap.configurations.lua = {
    {
      name = 'Current file (local-lua-dbg, lua)',
      type = 'local_lua',
      request = 'launch',
      cwd = '${workspaceFolder}',
      program = {
        lua = 'lua5.1',
        file = '${file}',
      },
      args = {},
    },
  }

  map ('<leader>Db', dap.toggle_breakpoint, 'Toggle Breakpoint [DAP]')
  map ('<leader>DB', function ()
    dap.set_breakpoint (vim.fn.input ('Breakpoint condition: '))
  end, 'Set Breakpoint [DAP]')
  map ('<F5>', dap.continue, 'Start/Continue [DAP]')
  map ('<F1>', dap.step_into, 'Step Into [DAP]')
  map ('<F2>', dap.step_over, 'Step Over [DAP]')
  map ('<F3>', dap.step_out, 'Step Out [DAP]')
  map ('<F4>', dap.step_back, 'Step Back [DAP]')
  map ('<F8>', dap.restart, 'Restart [DAP]')
  map ('<F9>', dap.terminate, 'Terminate [DAP]')
  map ('<leader>Dh', function ()
    require ('dap.ui.widgets').hover ()
  end, 'Hover [DAP]', { 'n', 'v' })
  map ('<leader>Dp', function ()
    require ('dap.ui.widgets').preview ()
  end, 'Preview [DAP]', { 'n', 'v' })
  map ('<leader>Df', function ()
    local widgets = require ('dap.ui.widgets')
    widgets.centered_float (widgets.frames)
  end, 'Float frame [DAP]')
  map ('<leader>Ds', function ()
    local widgets = require ('dap.ui.widgets')
    widgets.centered_float (widgets.scopes)
  end, 'Float scopes [DAP]')
end)
