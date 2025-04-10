local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'windwp/nvim-ts-autotag',
  })

  require ('nvim-ts-autotag').setup ()
end)
