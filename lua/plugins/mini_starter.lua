local map = require ('util').map

local now = MiniDeps.now
--
-- MiniStarter
-- :h mini.starter
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
--
now (function ()
  local starter = require ('mini.starter')

  local section = {
    resession = 'Resession:',
    neovim = 'Neovim:',
    search = 'Search:',
  }
  local items = {
    --
    -- Search
    --
    {
      action = 'lua require ("telescope").extensions.zoxide.list()',
      name = 'Change Directory',
      section = section.search,
    },
    {
      action = 'lua require ("telescope.builtin").find_files ({})',
      name = 'Search Files',
      section = section.search,
    },
    {
      action = 'lua require ("telescope.builtin").live_grep ({ layout_strategy = "vertical" })',
      name = 'Find Text',
      section = section.search,
    },
    {
      action = 'lua require ("telescope.builtin").oldfiles ({ previewer = false })',
      name = 'Recent Files',
      section = section.search,
    },
    --
    -- Resession
    --
    {
      action = 'lua require ("resession").load ()',
      name = 'Load Session',
      section = section.resession,
    },
  }

  starter.setup ({
    header = " _  _                 _\n| \\| | ___  ___ __ __(_) _ __  \n| .  |/ -_)/ _ \\\\ V /| || '  \\ \n|_|\\_|\\___|\\___/ \\_/ |_||_|_|_|\n",
    items = items,
    content_hooks = {
      starter.gen_hook.adding_bullet ('󱁺 '),
      starter.gen_hook.aligning ('center', 'center'),
    },
    footer = '',
  })

  map ('<leader>mS', starter.open, 'Starter [Mini]')
end)
