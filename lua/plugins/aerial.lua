local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'stevearc/aerial.nvim',
  })

  require ('aerial').setup ({
    layout = {
      default_direction = 'prefer_left',
      width = 40,
    },
    on_attach = function (bufnr)
      map ('{', '<cmd>AerialPrev<CR>', 'Prev [Aerial]', 'n', bufnr)
      map ('}', '<cmd>AerialNext<CR>', 'Next [Aerial]', 'n', bufnr)
    end,
  })

  local telescope = require ('telescope')
  telescope.setup ({
    extensions = {
      ['aerial'] = {
        col1_width = 4,
        col2_width = 30,
        format_symbol = function (symbol_path, filetype)
          if filetype == 'json' or filetype == 'yaml' then
            return table.concat (symbol_path, '.')
          else
            return symbol_path[#symbol_path]
          end
        end,
        show_columns = 'both',
      },
    },
  })
  vim.keymap.set ('n', '<leader>ta', telescope.extensions.aerial.aerial, { desc = 'Aerial [Telescope]' })

  map ('<leader>a', '<cmd>AerialToggle!<cr>', 'Toggel [Aerial]')
end)
