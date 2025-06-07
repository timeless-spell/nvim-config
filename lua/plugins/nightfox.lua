local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'EdenEast/nightfox.nvim',
  })

  require ('nightfox').setup ()

  vim.cmd ('colorscheme duskfox')
end)
