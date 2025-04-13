local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/lazydev.nvim',
  })

  require ('lazydev').setup ({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
    integrations = {
      cmp = false,
      lspconfig = false,
    },
  })
end)
