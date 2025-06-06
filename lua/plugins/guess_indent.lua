local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'NMAC427/guess-indent.nvim',
  })

  require ('guess-indent').setup ()
end)
