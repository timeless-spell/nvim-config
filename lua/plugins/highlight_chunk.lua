local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'shellRaining/hlchunk.nvim',
  })

  local chunk = require ('hlchunk')
  chunk.setup ({
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
    line_num = {
      enable = true,
      style = '#df6dfc',
      priority = 10,
      use_treesitter = false,
    },
  })
end)
