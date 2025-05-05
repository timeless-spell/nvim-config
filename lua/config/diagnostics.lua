local map = require ('util').map

-- Diagnostic config
vim.diagnostic.config ({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function (diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

-- [[ Diagnostic specific keymaps ]]
map ('<leader>dl', vim.diagnostic.setloclist, 'Open diagnostic [L]ocation list')
map ('<leader>dq', vim.diagnostic.setqflist, 'Open diagnostic [Q]uickfix list')
map ('<leader>dp', vim.diagnostic.get_prev, 'Open diagnostic Previous Diagnostic')
map ('<leader>dp', vim.diagnostic.get_next, 'Open diagnostic Next Diagnostic')
map ('<leader>df', vim.diagnostic.open_float, 'Open diagnostic [F]loat')
