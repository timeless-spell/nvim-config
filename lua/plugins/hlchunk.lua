local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'shellRaining/hlchunk.nvim',
  })

  require ('hlchunk').setup ({
    chunk = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    blank = {
      enable = true,
      chars = {
        ' ',
      },
      style = {
        { bg = vim.fn.synIDattr (vim.fn.synIDtrans (vim.fn.hlID ('cursorline')), 'bg', 'gui') },
        { bg = '', fg = '' },
      },
    },
  })
end)
