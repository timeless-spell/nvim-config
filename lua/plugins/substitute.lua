local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'gbprod/substitute.nvim',
  })

  local subs = require ('substitute')
  local subs_range = require ('substitute.range')
  local subs_exchange = require ('substitute.exchange')

  subs.setup ({
    on_substitute = function ()
      require ('yanky.integration').substitute ()
    end,
  })

  map ('<leader>so', subs.operator, 'Operator [Substitute')
  map ('<leader>sl', subs.line, 'Line [Substitute')
  map ('<leader>se', subs.eol, 'Eol [Substitute]')
  map ('<leader>sx', subs.visual, 'Visual [Substitute]', 'x')
  map ('<leader>sr', subs_range.operator, 'Operator Range [Substitute]')
  map ('<leader>sX', subs_range.visual, 'Visual Range [Substitute]', 'x')
  map ('<leader>sw', subs_range.word, 'Word Range [Substitute]')
  map ('<leader>sR', subs_exchange.operator, 'Exchange Operator [Substitute]')
  map ('<leader>sL', subs_exchange.line, 'Exchange Line [Substitute]')
  map ('<leader>sv', subs_exchange.visual, 'Exchange Visual [Substitute]', 'x')
  map ('<leader>sq', subs_exchange.cancel, 'Exchange Cancel [Substitute]')
end)
