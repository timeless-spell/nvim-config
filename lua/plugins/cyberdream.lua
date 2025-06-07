local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'scottmckendry/cyberdream.nvim',
  })

  require ('cyberdream').setup ()
end)
