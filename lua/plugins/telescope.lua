local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  local function build_fzf_native ()
    vim.notify ('Building FZF Native', vim.log.levels.INFO)
    local fzf_native_path = vim.fn.stdpath ('data') .. '/site/pack/deps/opt/telescope-fzf-native.nvim'
    local obj = vim.system ({ 'make' }, { cwd = fzf_native_path }):wait ()
    if obj.code == 0 then
      vim.notify ('Done succesfully', vim.log.levels.INFO)
    else
      vim.notify ('Build failed', vim.log.levels.ERROR)
    end
  end

  add ({
    source = 'nvim-telescope/telescope.nvim',
    checkout = '0.1.x',
    depends = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      -- 'nvim-telescope/telescope-ui-select.nvim', -- NOTE: Prefer Snacks.picker.select()
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    hooks = {
      post_install = build_fzf_native,
      post_checkout = build_fzf_native,
    },
  })

  local telescope = require ('telescope')
  local builtin = require ('telescope.builtin')
  local themes = require ('telescope.themes')
  local utils = require ('telescope.utils')
  local actions = require ('telescope.actions.')

  telescope.setup ({
    defaults = {
      prompt_prefix = '󰍉 ',
      selection_caret = '󰜴 ',
      entry_prefix = ' ',
      multi_icon = ' ',
      mappings = {
        i = {
          ['<c-down>'] = actions.cycle_history_next,
          ['<c-up>'] = actions.cycle_history_prev,
          ['<c-q>'] = actions.close,
        },
      },
      extensions = {
        ['fzf'] = {},
        ['file_browser'] = {
          path = '%:p:h',
          cwd_to_path = true,
          layout_strategy = 'center',
          layout_config = { height = 0.8, width = 0.8 },
          previewer = false,
          hijack_netrw = false,
          hidden = {
            file_browser = true,
            folder_browser = true,
          },
        },
        -- ['ui-select'] = {
        -- theme = themes.get_dropdown (),
        -- },
      },
    },
  })

  telescope.load_extension ('fzf')
  -- telescope.load_extension ('ui-select')
  telescope.load_extension ('file_browser')

  -- [[ Custom Telescope keymaps ]]
  -- `:h telescope.builtin`

  -- [[ File related keymaps ]]
  -- Find files:
  -- search files in the current working directory
  map ('<leader>tf', function ()
    builtin.find_files ({
      hidden = true,
      layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
    })
  end, 'Search [F]iles')

  -- search files in the buffer's current working directory
  map ('<leader>tc', function ()
    builtin.find_files ({
      cwd = utils.buffer_dir (),
      hidden = true,
      layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
    })
  end, 'Search Files ([c]urrent buffer)')

  -- Old files:
  -- search recently open files `:h telescope.builtin.oldfiles`
  map ('<leader>to', function ()
    builtin.oldfiles ({
      previewer = false,
      layout_strategy = 'vertical',
      layout_config = { prompt_position = 'top', width = 0.9 },
    })
  end, 'Search [O]ld Files')

  -- Live grep:
  -- `h: telescope.builtin.live_grep`
  map ('<leader>tg', function ()
    builtin.live_grep ({
      layout_strategy = 'vertical',
      layout_config = { prompt_position = 'bottom', width = 0.95, height = 0.95 },
    })
  end, 'Search by [G]rep')

  -- Search word under cursor:
  -- `:h telescope.builtin.grep_string`
  map ('<leader>tw', function ()
    builtin.grep_string ({
      layout_strategy = 'vertical',
      layout_config = { prompt_position = 'bottom', width = 0.95, height = 0.95 },
    })
  end, 'Search current [W]ord')

  -- Fuzzy search in buffer:
  -- `:h telescope.builtin.current_buffer_fuzzy_find`
  map ('<leader>t/', function ()
    builtin.current_buffer_fuzzy_find ({
      layout_strategy = 'center',
      windblend = 10,
      previewer = false,
      layout_config = { width = 0.6, height = 0.55 },
    })
  end, '[/] Fuzzily search in current buffer')

  -- Open telescope file browser (Extension):
  -- `:h telescope-file-browser`
  map ('<leader>tb', function ()
    telescope.extensions.file_browser.file_browser ({
      cwd = vim.fn.expand ('%:p:h'),
      layout_strategy = 'horizontal',
      layout_config = {
        height = 0.95,
        prompt_position = 'top',
        width = 0.95,
        preview_width = 0.60,
      },
      grouped = true,
      -- depth = 2,
      hidden = {
        file_browser = true,
        folder_browser = true,
      },
      respect_gitignore = false,
      previewer = true,
    })
  end, 'File [B]rowser')

  -- [[ Neovim related keymaps ]]
  -- Open quickfix:
  -- `:h telescope.builtin.quickfix`
  map ('<leader>tq', function ()
    builtin.quickfix ({
      layout_strategy = 'center',
      prompt_position = 'bottom',
      layout_config = { width = 0.75 },
      previewer = false,
    })
  end, '[Q]uiqfix')

  -- Search open existing buffers:
  -- `:h telescope.builtin.buffers`
  map ('<leader>t<leader>', function ()
    builtin.buffers ({
      previewer = false,
      layout_strategy = 'center',
      layout_config = { height = 0.5, width = 0.7 },
    })
  end, 'Search Open Buffers')

  -- Search help tags:
  map ('<leader>th', function ()
    builtin.help_tags ({
      layout_strategy = 'bottom_pane',
      layout_config = { prompt_position = 'bottom', height = 0.8, preview_width = 0.7 },
    })
  end, 'Search [H]elp')

  -- Search Neovim config files:
  map ('<leader>tn', function ()
    builtin.find_files ({
      cwd = vim.fn.stdpath ('config'),
      previewer = false,
      layout_strategy = 'center',
      layout_config = { height = 0.7 },
    })
  end, 'Search [N]eovim Files')

  -- Search keymaps:
  -- `:h telescope.builtin.keymaps`
  map ('<leader>tk', function ()
    builtin.keymaps ({ layout_strategy = 'center', layout_config = { width = 0.7, height = 0.6 } })
  end, '[S]earch [K]eymaps')

  map ('<leader>tl', function ()
    builtin.find_files ({
      cwd = vim.fs.joinpath (vim.fn.stdpath ('data'), 'site'),
      hidden = true,
      layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
    })
  end, 'Search Files ([L]azy)')
end)
