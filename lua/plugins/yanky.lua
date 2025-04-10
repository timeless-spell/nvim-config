local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'gbprod/yanky.nvim',
  })

  require ('yanky').setup ({
    highlight = {
      on_put = true,
      on_yank = false,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
    on_substitute = function ()
      require ('yanky.integration').substitute ()
    end,
  })

  map ('<leader>ty', function ()
    require ('telescope').extensions.yank_history.yank_history ({
      previewer = false,
      layout_strategy = 'cursor',
      layout_config = {
        height = 0.3,
        width = 0.4,
      },
    })
  end, 'Yanky History')

  map ('p', '<Plug>(YankyPutAfter)', 'Put After [Yanky]', { 'n', 'x' })
  map ('P', '<Plug>(YankyPutBefore)', 'Put Before [Yanky]', { 'n', 'x' })
  map ('gp', '<Plug>(YankyGPutAfter)', 'GPut Ater [Yanky]', { 'n', 'x' })
  map ('gP', '<Plug>(YankyGPutBefore)', 'GPut Before [Yanky]', { 'n', 'x' })
  map ('y', '<Plug>(YankyYank)', 'Yank [Yanky]', { 'n', 'x' })
  map ('<a-[>', '<Plug>(YankyPreviousEntry)', 'Previous Entry [Yanky]')
  map ('<a-]>', '<Plug>(YankyNextEntry)', 'Next Entry [Yanky]')
  map (']p', '<Plug>(YankyPutIndentAfterLinewise)', 'Put Indent After Line [Yanky]')
  map ('[p', '<Plug>(YankyPutIndentBeforeLinewise)', 'Put Indent Before Line [Yanky]')
  map (']P', '<Plug>(YankyPutIndentAfterLinewise)', 'Put Indent After Line [Yanky]')
  map ('[P', '<Plug>(YankyPutIndentBeforeLinewise)', 'Put Indent Before Line [Yanky]')
  map ('>p', '<Plug>(YankyPutIndentAfterShiftRight)', 'Put Indent After Shift Right [Yanky]')
  map ('<p', '<Plug>(YankyPutIndentAfterShiftLeft)', 'Put Indent After Shift Left [Yanky]')
  map ('>P', '<Plug>(YankyPutIndentBeforeShiftRight)', 'Put Indent Before Shift Right [Yanky]')
  map ('<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', 'Put Indent Before Shift Left [Yanky]')
  map ('=p', '<Plug>(YankyPutAfterFilter)', 'Put After Filter [Yanky]')
  map ('=P', '<Plug>(YankyPutBeforeFilter)', 'Put Before Filter [Yanky]')
end)
