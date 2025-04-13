local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'NeogitOrg/neogit',
    depends = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
  })

  require ('neogit').setup ()

  map ('<leader>gn', '<cmd>Neogit<cr>', 'Neogit')
end)
