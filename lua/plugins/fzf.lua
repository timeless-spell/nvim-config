local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'ibhagwan/fzf-lua',
  })

  local fzf = require ('fzf-lua')

  fzf.setup ({
    files = {
      previewer = 'bat',
    },
  })

  --
  -- Buffers and Files
  --
  map ('<leader>ff', fzf.files, 'Files [Fzf]')
  map ('<leader>fx', function ()
    fzf.files ({ cwd = '~' })
  end, 'Global [Fzf]')
  map ('<leader>fC', function ()
    fzf.files ({ cwd = '~/.config' })
  end, 'Config [Fzf]')
  map ('<leader>fb', fzf.buffers, 'Buffers [Fzf]')
  map ('<leader>fo', fzf.oldfiles, 'Recent files [Fzf]')
  map ('<leader>fq', fzf.quickfix, 'Quickfix list [Fzf]')
  map ('<leader>fQ', fzf.quickfix_stack, 'Quickfix stack [Fzf]')
  map ('<leader>fc', fzf.loclist, 'Loclist list [Fzf]')
  map ('<leader>fC', fzf.loclist_stack, 'Loclist stack [Fzf]')
  map ('<leader>fn', fzf.lines, 'Open buffers lines [Fzf]')
  map ('<leader>fN', fzf.blines, 'Current buffer lines [Fzf]')
  map ('<leader>fT', fzf.treesitter, 'Current buffer Treesitter symbols [Fzf]')
  map ('<leader>ft', fzf.tabs, 'Open tabs [Fzf]')
  map ('<leader>fa', fzf.args, 'Argument list [Fzf]')

  --
  -- Search
  --
  map ('<leader>fwg', fzf.grep, 'Search pattern [Fzf]')
  map ('<leader>fwl', fzf.grep_last, 'Search last pattern [Fzf]')
  map ('<leader>fww', fzf.grep_cword, 'Search word under cursor [Fzf]')
  map ('<leader>fwW', fzf.grep_cWORD, 'Search WORD under cursor [Fzf]')
  map ('<leader>fwV', fzf.grep_visual, 'Search visual selection [Fzf]')
  map ('<leader>fwp', fzf.grep_project, 'Search all project lines [Fzf]')
  map ('<leader>fwb', fzf.grep_curbuf, 'Search current buffer lines [Fzf]')
  map ('<leader>fwq', fzf.grep_quickfix, 'Search the quickfix list [Fzf]')
  map ('<leader>fwc', fzf.grep_loclist, 'Search the loccation list [Fzf]')

  map ('<leader>fwf', fzf.lgrep_curbuf, 'Live grep curent buffer [Fzf]')
  map ('<leader>fwx', fzf.lgrep_quickfix, 'Live grep the quickfix list [Fzf]')
  map ('<leader>fws', fzf.lgrep_loclist, 'Live grep the location list[Fzf]')
  map ('<leader>fwv', fzf.live_grep, 'Live grep current project [Fzf]')
  map ('<leader>fwr', fzf.live_grep_resume, 'Live grep last search [Fzf]')
  map ('<leader>fwo', fzf.live_grep_glob, 'Live grep "rg --glob" [Fzf]')
  map ('<leader>fwG', fzf.live_grep_native, 'Live grep native [Fzf]')

  --
  -- LSP
  --
  map ('<leader>flr', fzf.lsp_references, 'LSP References [Fzf]')
  map ('<leader>fld', fzf.lsp_definitions, 'LSP Definitions [Fzf]')
  map ('<leader>flD', fzf.lsp_declarations, 'LSP Declarations [Fzf]')
  map ('<leader>flt', fzf.lsp_typedefs, 'LSP Type Definitions [Fzf]')
  map ('<leader>fli', fzf.lsp_implementations, 'LSP Implementations [Fzf]')
  map ('<leader>fls', fzf.lsp_document_symbols, 'LSP Document Symbols [Fzf]')
  map ('<leader>flw', fzf.lsp_workspace_symbols, 'LSP Workspace Symbols [Fzf]')
  map ('<leader>flW', fzf.lsp_live_workspace_symbols, 'LSP Workspace Symbols (live query) [Fzf]')
  map ('<leader>fla', fzf.lsp_code_actions, 'LSP Code Actions [Fzf]')
  map ('<leader>flF', fzf.lsp_finder, 'LSP Locations, combined view [Fzf]')
  map ('<leader>flg', fzf.lsp_document_diagnostics, 'LSP Diagnostics Document [Fzf]')
  map ('<leader>flG', fzf.lsp_workspace_diagnostics, 'LSP Diagnostics Workspace [Fzf]')

  --
  -- Zoxide
  --
  map ('<leader>Z', fzf.zoxide, 'Zoxide [Fzf]')
end)
