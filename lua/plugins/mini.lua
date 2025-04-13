local map = require ('util').map

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

--
-- [[ Starter ]]
--
now (function ()
  local starter = require ('mini.starter')
  local section = {
    resession = '\t\t⭐[Resession]⭐',
    neovim = '\t\t⭐[Neovim]⭐',
    files = '\t\t⭐[Files]⭐',
  }
  starter.setup ({
    header = " _  _                 _\n| \\| | ___  ___ __ __(_) _ __  \n| .  |/ -_)/ _ \\\\ V /| || '  \\ \n|_|\\_|\\___|\\___/ \\_/ |_||_|_|_|\n",
    items = {
      {
        name = 'Load Session',
        action = 'lua require("resession").load()',
        section = section.resession,
      },
      {
        name = 'Global',
        action = 'FzfLua files cwd=$HOME',
        section = section.files,
      },
      {
        name = 'Find Files',
        action = 'Telescope find_files layout_config={"width":0.95,"preview_width":0.6,"height":0.95}',
        section = section.files,
      },
      {
        name = 'File Browser',
        action = 'Telescope file_browser file_browser previewer=true layout_strategy=bottom_pane layout_config={"height":0.85}',
        section = section.files,
      },
      {
        name = 'Recent Files',
        action = 'Telescope oldfiles previewer=false layout_strategy=vertical layout_config={"width":0.8,"prompt_position":"top"}',
        section = section.files,
      },
      {
        name = 'Files',
        action = 'Telescope find_files cwd=$HOME/.config/nvim layout_config={"width":0.95,"preview_width":0.6,"height":0.95}',
        section = section.neovim,
      },
      {
        name = 'Plugins',
        action = 'Telescope file_browser file_browser path=~/.config/nvim/lua/plugins previewer=false layout_strategy=center layout_config={"height":0.7}',
        section = section.neovim,
      },
      {
        name = 'Directory',
        action = 'Telescope file_browser file_browser path=~/.config/nvim layout_strategy=horizontal layout_config={"height":0.90,"prompt_position":"top","width":0.90,"preview_width":0.65} grouped=true depth=2 hidden={"file_browser":true,"folder_browser":true} respect_gitignore=false previewer=true',
        section = section.neovim,
      },
    },
    content_hooks = {
      starter.gen_hook.adding_bullet (''),
      starter.gen_hook.aligning ('center', 'center'),
    },
    footer = '\t\tᶻ 𝗓 𐰁 .ᐟ',
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
