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

  dapui.setup ()

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  map ('<leader>db', dap.toggle_breakpoint, 'Toggle Breakpoint [DAP]')
  map ('<leader>dB', dap.toggle_breakpoint, 'Set Breakpoint [DAP]')
  map ('<leader>dc', dap.continue, 'Start/Continue [DAP]')
  map ('<leader>dx', dap.restart, 'Restart [DAP]')
  map ('<leader>di', dap.step_into, 'Step Into [DAP]')
  map ('<leader>dv', dap.step_over, 'Step Over [DAP]')
  map ('<leader>do', dap.step_out, 'Step Out [DAP]')
  map ('<leader>dk', dap.step_back, 'Step Back [DAP]')
  map ('<leader>dq', dap.terminate, 'Terminate [DAP]')
  map ('<leader>dh', function ()
    require ('dap.ui.widgets').hover ()
  end, 'Hover [DAP]', { 'n', 'v' })
  map ('<leader>dp', function ()
    require ('dap.ui.widgets').preview ()
  end, 'Preview [DAP]', { 'n', 'v' })
  map ('<leader>df', function ()
    local widgets = require ('dap.ui.widgets')
    widgets.centered_float (widgets.frames)
  end, 'Float frame [DAP]')
  map ('<leader>ds', function ()
    local widgets = require ('dap.ui.widgets')
    widgets.centered_float (widgets.scopes)
  end, 'Float scopes [DAP]')

  vim.api.nvim_create_user_command ('DAPUIopen', function ()
    dapui.open ()
  end, {})

  vim.api.nvim_create_user_command ('DAPUIclose', function ()
    dapui.close ()
  end, {})

  vim.api.nvim_create_user_command ('DAPUItoggle', function ()
    dapui.toggle ()
  end, {})

  vim.api.nvim_create_user_command ('DAPUIfloat', function ()
    dapui.float_element ()
  end, {})

  vim.api.nvim_create_user_command ('DAPUIeval', function ()
    dapui.eval (nil, { enter = true })
  end, {})
end)
