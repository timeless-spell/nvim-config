local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/which-key.nvim',
  })

  local wk = require ('which-key')

  wk.setup ({
    preset = 'helix',
  })

  wk.add ({
    { '<leader>t', group = 'Telescope', icon = '󰭎' },
    { '<leader>tl', group = 'LSP', icon = '' },
    { '<leader>m', group = 'Mini', icon = '󰨅' },
    { '<leader>T', group = 'Trouble', icon = '󱈎' },
    { '<leader>g', group = 'Git', icon = '' },
    { '<leader>f', group = 'FzfLua', icon = '󰍉' },
    { '<leader>fw', group = 'Grep', icon = '󰍉' },
    { '<leader>fg', group = 'Git', icon = '󰍉' },
    { '<leader>fl', group = 'LSP', icon = '󰍉' },
    { '<leader>l', group = 'LSP', icon = '󰒋' },
    { '<leader>lg', group = 'Go to', icon = '󰒋' },
    { '<leader>ld', group = 'Diagnostics', icon = '' },
    { '<leader>d', group = 'DAP', icon = '' },
    { '<leader>r', group = 'Resession', icon = '󰹑' },
    { '\\', group = 'Snacks', icon = '󱁤' },
    { '<leader>b', group = 'Buffer', icon = '󰯉' },
  })

  map ('<leader>\\', function ()
    wk.show ({ global = false })
  end, 'Which-Key: Buffer Local Keymaps')
end)
