local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'lewis6991/gitsigns.nvim',
  })

  local gitsigns = require ('gitsigns')

  gitsigns.setup ({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    numhl = true,
    update_debounce = 500,
  })

  map (']c', function ()
    if vim.wo.diff then
      vim.cmd.normal ({ ']c', bang = true })
    else
      gitsigns.nav_hunk ('next')
    end
  end, 'Jump to next git [c]hange')
  map (']c', function ()
    if vim.wo.diff then
      vim.cmd.normal ({ ']c', bang = true })
    else
      gitsigns.nav_hunk ('prev')
    end
  end, 'Jump to previous git [c]hange')

  -- Actions
  -- Visual Mode
  map ('<leader>gs', function ()
    gitsigns.stage_hunk ({ vim.fn.line ('.'), vim.fn.line ('v') })
  end, 'stage git hunk', 'v')
  map ('<leader>gr', function ()
    gitsigns.reset_hunk ({ vim.fn.line ('.'), vim.fn.line ('v') })
  end, 'reset git hunk', 'v')
  map ('<leader>gs', gitsigns.stage_hunk, 'git [s]tage hunk')
  map ('<leader>gr', gitsigns.reset_hunk, 'git [r]eset hunk')
  map ('<leader>gS', gitsigns.stage_buffer, 'git [S]tage buffer')
  map ('<leader>gp', gitsigns.preview_hunk, 'git [p]review hunk')
  map ('<leader>gP', gitsigns.preview_hunk_inline, 'git [P]review hunk')
  map ('<leader>gR', gitsigns.reset_buffer, 'git [R]eset buffer')
  map ('<leader>gb', gitsigns.blame_line, 'git [b]lame line')
  map ('<leader>gd', gitsigns.diffthis, 'git [d]iff against index')
  map ('<leader>gD', function ()
    gitsigns.diffthis ('@')
  end, 'git [D]iff against last commit')

  -- Toggle
  map ('<leader>gtb', gitsigns.toggle_current_line_blame, 'Toggle [g]it show [b]lame line')

  -- Text objects
  map ('<leader>gs', gitsigns.select_hunk, '[g]it [S]elect Hunk', { 'o', 'x' })
end)
