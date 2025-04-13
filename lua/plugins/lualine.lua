local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'nvim-lualine/lualine.nvim',
  })

  require ('lualine').setup ({
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_x = { 'lsp_status' },
    },
  })
end)
