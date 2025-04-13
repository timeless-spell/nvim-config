local map = require ('util').map

local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'folke/snacks.nvim',
  })

  require ('snacks').setup ({
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    explorer = { enabled = true },
    picker = {
      win = {
        input = {
          keys = {
            ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
            ['s'] = { 'flash' },
          },
        },
      },
      actions = {
        flash = function (picker)
          require ('flash').jump ({
            pattern = '^',
            label = { after = { 0, 0 } },
            search = {
              mode = 'search',
              exclude = {
                function (win)
                  return vim.bo[vim.api.nvim_win_get_buf (win)].filetype ~= 'snacks_picker_list'
                end,
              },
            },
            action = function (match)
              local idx = picker.list:row2idx (match.pos[1])
              picker.list:_move (idx, true, true)
            end,
          })
        end,
      },
      sources = {
        explorer = {
          layout = {
            layout = {
              position = 'right',
            },
          },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd ('User', {
    pattern = 'MiniFilesActionRename',
    callback = function (event)
      Snacks.rename.on_rename_file (event.data.from, event.data.to)
    end,
  })

  map ('\\<space>', function ()
    Snacks.picker.smart ()
  end, 'Smart Find Files')

  map ('\\,', function ()
    Snacks.picker.buffers ()
  end, 'Buffers')

  map ('\\/', function ()
    Snacks.picker.grep ()
  end, 'Grep')

  map ('\\:', function ()
    Snacks.picker.command_history ()
  end, 'Command History')

  map ('\\n', function ()
    Snacks.picker.notifications ()
  end, 'Notification History')

  map ('\\e', function ()
    Snacks.explorer ()
  end, 'File Explorer')

  -- find
  map ('\\fb', function ()
    Snacks.picker.buffers ()
  end, 'Buffers')

  map ('\\fc', function ()
    Snacks.picker.files ({ cwd = vim.fn.stdpath ('config') })
  end, 'Find Config File')

  map ('\\ff', function ()
    Snacks.picker.files ()
  end, 'Find Files')

  map ('\\fg', function ()
    Snacks.picker.git_files ()
  end, 'Find Git Files')

  map ('\\fp', function ()
    Snacks.picker.projects ()
  end, 'Projects')

  map ('\\fr', function ()
    Snacks.picker.recent ()
  end, 'Recent')

  -- git
  map ('\\gb', function ()
    Snacks.picker.git_branches ()
  end, 'Git Branches')

  map ('\\gl', function ()
    Snacks.picker.git_log ()
  end, 'Git Log')

  map ('\\gL', function ()
    Snacks.picker.git_log_line ()
  end, 'Git Log Line')

  map ('\\gs', function ()
    Snacks.picker.git_status ()
  end, 'Git Status')

  map ('\\gS', function ()
    Snacks.picker.git_stash ()
  end, 'Git Stash')

  map ('\\gd', function ()
    Snacks.picker.git_diff ()
  end, 'Git Diff (Hunks)')

  map ('\\gf', function ()
    Snacks.picker.git_log_file ()
  end, 'Git Log File')

  -- Grep
  map ('\\sb', function ()
    Snacks.picker.lines ()
  end, 'Buffer Lines')

  map ('\\sB', function ()
    Snacks.picker.grep_buffers ()
  end, 'Grep Open Buffers')

  map ('\\sg', function ()
    Snacks.picker.grep ()
  end, 'Grep')

  map ('\\sw', function ()
    Snacks.picker.grep_word ()
  end, 'Visual selection or word', { 'n', 'x' })

  -- search
  map ('\\s"', function ()
    Snacks.picker.registers ()
  end, 'Registers')

  map ('\\s/', function ()
    Snacks.picker.search_history ()
  end, 'Search History')

  map ('\\sa', function ()
    Snacks.picker.autocmds ()
  end, 'Autocmds')

  map ('\\sb', function ()
    Snacks.picker.lines ()
  end, 'Buffer Lines')

  map ('\\sc', function ()
    Snacks.picker.command_history ()
  end, 'Command History')

  map ('\\sC', function ()
    Snacks.picker.commands ()
  end, 'Commands')

  map ('\\sd', function ()
    Snacks.picker.diagnostics ()
  end, 'Diagnostics')

  map ('\\sD', function ()
    Snacks.picker.diagnostics_buffer ()
  end, 'Buffer Diagnostics')

  map ('\\sh', function ()
    Snacks.picker.help ()
  end, 'Help Pages')

  map ('\\sH', function ()
    Snacks.picker.highlights ()
  end, 'Highlights')

  map ('\\si', function ()
    Snacks.picker.icons ()
  end, 'Icons')

  map ('\\sj', function ()
    Snacks.picker.jumps ()
  end, 'Jumps')

  map ('\\sk', function ()
    Snacks.picker.keymaps ()
  end, 'Keymaps')

  map ('\\sl', function ()
    Snacks.picker.loclist ()
  end, 'Location List')

  map ('\\sm', function ()
    Snacks.picker.marks ()
  end, 'Marks')

  map ('\\sM', function ()
    Snacks.picker.man ()
  end, 'Man Pages')

  map ('\\sp', function ()
    Snacks.picker.lazy ()
  end, 'Search for Plugin Spec')

  map ('\\sq', function ()
    Snacks.picker.qflist ()
  end, 'Quickfix List')

  map ('\\sR', function ()
    Snacks.picker.resume ()
  end, 'Resume')

  map ('\\su', function ()
    Snacks.picker.undo ()
  end, 'Undo History')

  map ('\\uC', function ()
    Snacks.picker.colorschemes ()
  end, 'Colorschemes')

  -- LSP
  map ('\\ld', function ()
    Snacks.picker.lsp_definitions ()
  end, 'Goto Definition')

  map ('\\lD', function ()
    Snacks.picker.lsp_declarations ()
  end, 'Goto Declaration')

  map ('\\lr', function ()
    Snacks.picker.lsp_references ()
  end, 'References')

  map ('\\lI', function ()
    Snacks.picker.lsp_implementations ()
  end, 'Goto Implementation')

  map ('\\ly', function ()
    Snacks.picker.lsp_type_definitions ()
  end, 'Goto T[y]pe Definition')

  map ('\\ls', function ()
    Snacks.picker.lsp_symbols ()
  end, 'LSP Symbols')

  map ('\\lS', function ()
    Snacks.picker.lsp_workspace_symbols ()
  end, 'LSP Workspace Symbols')
end)
