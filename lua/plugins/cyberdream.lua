local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'scottmckendry/cyberdream.nvim',
  })

  require ('cyberdream').setup ({
    variant = 'dark',
    transparent = true,
    cache = false,
  })

  vim.cmd.colorscheme ('cyberdream')
end)
