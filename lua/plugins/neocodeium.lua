local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'monkoose/neocodeium',
  })

  local neocodeium = require ('neocodeium')

  neocodeium.setup ({
    filetypes = {
      TelescopePrompt = false,
      ['dap-repl'] = false,
    },
  })

  map ('<c-c>', neocodeium.accept, 'Accept [Neocodeium]', 'i')
  map ('<c-v>', neocodeium.accept_word, 'Accept Word [Neocodeium]', 'i')
  map ('<c-d>', neocodeium.accept_line, 'Accept Line [Neocodeium]', 'i')
  map ('<c-x>', neocodeium.clear, 'Clear [Neocodeium]', 'i')
  map ('<c-;>', neocodeium.cycle, 'Next [Neocodeium]', 'i')
  map ('<c-,>', function ()
    neocodeium.cycle (-1)
  end, 'Prev [Neocodeium]', 'i')
end)
