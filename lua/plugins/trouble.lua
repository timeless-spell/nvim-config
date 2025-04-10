local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/trouble.nvim',
  })

  map ('<leader>Td', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics [Trouble]')

  map ('<leader>TD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics [Trouble]')

  map ('<leader>Ts', '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols [Trouble]')

  map (
    '<leader>Tg',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    'LSP Definitions / references / .. [Trouble]'
  )

  map ('<leader>Tl', '<cmd>Trouble loclist toggle<cr>', 'Location List [Trouble]')

  map ('<leader>Tq', '<cmd>Trouble qflist toggle<cr>', 'Quickfix List [Trouble]')
end)
