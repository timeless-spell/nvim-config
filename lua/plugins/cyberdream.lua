local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'scottmckendry/cyberdream.nvim',
  })

  require ('cyberdream').setup ()

  vim.cmd ('colorscheme cyberdream')
end)
