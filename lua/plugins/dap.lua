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
  dap.adapters.local_lua = {
    type = 'executable',
    command = 'node',
    args = {
      vim.env.HOME .. '/local/local-lua-debugger-vscode/extension/debugAdapter.js',
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

  vim.api.nvim_create_user_command ('DAPUIeval', function ()
    dapui.eval (nil, { enter = true })
  end, {})
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

  dap.configurations.java = {
    {
      name = 'Debug Launch (2GB)',
      type = 'java',
      request = 'launch',
      vmArgs = '' .. '-Xmx2g ',
    },
    {
      name = 'Debug Attach (8000)',
      type = 'java',
      request = 'attach',
      hostName = '127.0.0.1',
      port = 8000,
    },
    {
      name = 'Debug Attach (5005)',
      type = 'java',
      request = 'attach',
      hostName = '127.0.0.1',
      port = 5005,
    },
    {
      name = 'My Custom Java Run Configuration',
      type = 'java',
      request = 'launch',
      -- You need to extend the classPath to list your dependencies.
      -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
      -- classPaths = {},

      -- If using multi-module projects, remove otherwise.
      -- projectName = "yourProjectName",

      -- javaExec = "java",
      mainClass = 'replace.with.your.fully.qualified.MainClass',

      -- If using the JDK9+ module system, this needs to be extended
      -- `nvim-jdtls` would automatically populate this property
      -- modulePaths = {},
      vmArgs = '' .. '-Xmx2g ',
    },
  }
end)
