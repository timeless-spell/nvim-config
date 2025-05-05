local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/lazydev.nvim',
  })

  add ({
    source = 'Bilal2453/luvit-meta',
  })

  require ('lazydev').setup ({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { 'nvim-dap-ui' },
      { 'blink.cmp.types' },
    },
    integrations = {
      cmp = false,
    },
  })
end)
