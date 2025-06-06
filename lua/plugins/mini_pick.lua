local map = require ('util').map

local later = MiniDeps.later
--
-- MiniPick
-- :h mini.pick
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pick.md
--
later (function ()
  require ('mini.pick').setup ()

  map ('<leader>msg', function ()
    MiniPick.builtin.grep_live ()
  end, 'Live Grep [MiniPick]')
  map ('<leader>msf', function ()
    MiniPick.builtin.files ()
  end, 'Search Files [MiniPick]')
end)
