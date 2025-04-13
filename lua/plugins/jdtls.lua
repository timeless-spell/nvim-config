local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'mfussenegger/nvim-jdtls',
  })
end)
