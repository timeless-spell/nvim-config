local map = require ('util').map

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

--
-- [[ Starter ]]
--
now (function ()
  local starter = require ('mini.starter')

  local items = {
    --
    -- Search
    --
    {
      action = 'lua require ("telescope.builtin").find_files ({previewer=false,hidden=true})',
      name = 'Search Files',
      section = 'Search',
    },
    {
      action = 'lua require ("telescope.builtin").live_grep ({})',
      name = 'Find Text',
      section = 'Search',
    },
    {
      action = 'lua require ("telescope.builtin").oldfiles ({previewer=false})',
      name = 'Recent Files',
      section = 'Search',
    },
    {
      action = 'lua require ("telescope").extensions.zoxide.list({previewer=false})',
      name = 'Change Directory',
      section = 'Search',
    },
    --
    -- Resession
    --
    {
      action = 'lua require ("resession").load ()',
      name = 'Load Session',
      section = 'Resession',
    },
    --
    -- neovim
    --
    {
      action = 'lua require ("telescope.builtin").find_files ({cwd=vim.fn.stdpath("config"),previewer=false})',
      name = 'Config',
      section = 'Neovim',
    },
  }

  starter.setup ({
    header = " _  _                 _\n| \\| | ___  ___ __ __(_) _ __  \n| .  |/ -_)/ _ \\\\ V /| || '  \\ \n|_|\\_|\\___|\\___/ \\_/ |_||_|_|_|\n",
    items = items,
    content_hooks = {
      starter.gen_hook.adding_bullet ('󱁺 '),
      starter.gen_hook.aligning ('center', 'top'),
    },
    footer = '\tᶻ 𝗓 𐰁 .ᐟ',
  })

  map ('<leader>ms', starter.open, 'Starter [Mini]')
end)

--
-- [[ Files ]]
--
later (function ()
  local files = require ('mini.files')

  files.setup ({
    options = {
      use_as_default_explorer = false,
    },
  })

  map ('<leader>mf', files.open, 'Files Open [Mini]')
end)
--
-- [[ Icons ]]
--
now (function ()
  require ('mini.icons').setup ()
end)

--
-- [[ AI ]]
--
later (function ()
  require ('mini.ai').setup ()
end)

-- [[ Cursorword ]]
later (function ()
  require ('mini.cursorword').setup ()
end)

-- [[ Move ]]
later (function ()
  require ('mini.move').setup ()
end)

--
-- [[ Surround ]]
--
later (function ()
  require ('mini.surround').setup ({
    mappings = {
      add = 'msa',
      delete = 'msd',
      find = 'msf',
      find_left = 'msF',
      highlight = 'msh',
      replace = 'msr',
      update_n_lines = 'msn',

      suffix_last = 'l',
      suffix_next = 'n',
    },
  })
end)

--
-- [[ Comment ]]
--
later (function ()
  add ({
    source = 'JoosepAlviste/nvim-ts-context-commentstring',
  })

  require ('mini.comment').setup ({
    options = {
      custom_commentstring = function ()
        return require ('ts_context_commentstring').calculate_commentstring () or vim.bo.commentstring
      end,
    },
  })
end)

--
-- [[ Pick ]]
--

later (function ()
  require ('mini.pick').setup ()
end)
