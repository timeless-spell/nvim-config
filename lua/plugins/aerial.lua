local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'stevearc/aerial.nvim',
  })

  require ('aerial').setup ({
    layout = {
      default_direction = 'prefer_left',
      width = 40,
    },
    on_attach = function (bufnr)
      map ('{', '<cmd>AerialPrev<CR>', 'Prev [Aerial]', 'n', bufnr)
      map ('}', '<cmd>AerialNext<CR>', 'Next [Aerial]', 'n', bufnr)
    end,
  })

  map ('<leader>a', '<cmd>AerialToggle!<cr>', 'Toggel [Aerial]')
end)
