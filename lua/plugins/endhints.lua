local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'chrisgrieser/nvim-lsp-endhints',
  })

  require ('lsp-endhints').setup ()
end)
