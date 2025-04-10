local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'stevearc/resession.nvim',
  })

  local res = require ('resession')

  res.setup ({
    autosave = {
      enabled = true,
      interval = 60,
      notify = true,
    },
  })

  map ('<leader>rs', res.save, 'Save [Ressesion]')
  map ('<leader>rl', res.load, 'Load [Ressesion]')
  map ('<leader>rd', res.delete, 'Delete [Ressesion]')

  vim.api.nvim_create_autocmd ('VimLeavePre', {
    group = vim.api.nvim_create_augroup ('Resession', { clear = true }),
    desc = 'Auto save session when quit',
    callback = function (event)
      res.save ('last')
    end,
  })
end)
