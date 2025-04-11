local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/flash.nvim',
  })

  map ('s', function ()
    require ('flash').jump ()
  end, 'Jump [Flash]', { 'n', 'x', 'o' })

  map ('S', function ()
    require ('flash').treesitter ()
  end, 'Treesitter [Flash]', { 'n', 'x', 'o' })

  map ('r', function ()
    require ('flash').remote ()
  end, 'Remote [Flash]', 'o')

  map ('R', function ()
    require ('flash').treesitter_search ()
  end, 'Treesitter Search [Flash]', { 'o', 'x' })

  map ('<c-s>', function ()
    require ('flash').toggle ()
  end, 'Toggle Search [Flash]', { 'c' })
end)
