local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'chrisgrieser/nvim-spider',
  })

  local spider = require ('spider')
  spider.setup ({
    skipInsignificantPunctuation = false,
  })

  map ('e', function ()
    spider.motion ('e')
  end, 'Spider [e]')

  map ('w', function ()
    spider.motion ('w')
  end, 'Spider [w]')

  map ('w', function ()
    spider.motion ('b')
  end, 'Spider [b]')
end)
