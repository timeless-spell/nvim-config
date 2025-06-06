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
      lualine_c = { 'filename', 'aerial' },
      lualine_x = { 'lsp_status', 'encoding', 'fileformat', 'filetype' },
    },
  })
end)
