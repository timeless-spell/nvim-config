local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'gbprod/substitute.nvim',
  })

  local subs = require ('substitute')

  subs.setup ({
    on_substitute = function ()
      require ('yanky.integration').substitute ()
    end,
  })

  map ('<leader>s', subs.operator, 'Substitute operator')
  map ('<leader>ss', subs.line, 'Substitute line')
  map ('<leader>S', subs.eol, 'Substitute eol')
  map ('<leader>s', subs.visual, 'Substitute visual', 'x')
end)
