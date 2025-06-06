local map = require ('util').map

local now = MiniDeps.now

--
-- MiniFiles
-- :h mini.files
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
now (function ()
  local files = require ('mini.files')

  files.setup ({
    options = {
      use_as_default_explorer = false,
    },
  })

  map ('<leader>mf', files.open, 'Files Open [Mini]')
end)
