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

  map ('<leader>so', subs.operator, 'Operator [ Substitute ]')
  map ('<leader>sl', subs.line, 'Operator [ Substitute ]')
  map ('<leader>se', subs.eol, 'End of Line [ Substitute ]')
  map ('<leader>sx', subs.visual, 'Visual [Substitute]', 'x')
  map ('<leader>sr', require ('substitute.range').operator, 'Operator Range [Substitute]')
  map ('<leader>sX', require ('substitute.range').visual, 'Visual Range [Substitute]', 'x')
  map ('<leader>sw', require ('substitute.range').word, 'Word Range [Substitute]')
  map ('<leader>sR', require ('substitute.exchange').operator, 'Exchange Operator [Substitute]')
  map ('<leader>sL', require ('substitute.exchange').line, 'Exchange Line [Substitute]')
  map ('<leader>sv', require ('substitute.exchange').visual, 'Exchange Line [Substitute]', 'x')
  map ('<leader>sq', require ('substitute.exchange').cancel, 'Exchange Cancel [Substitute]')
end)
