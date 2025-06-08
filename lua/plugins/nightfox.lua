local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'EdenEast/nightfox.nvim',
  })

  require ('nightfox').setup ()
end)
