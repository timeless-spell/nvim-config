local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/todo-comments.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  })

  require ('todo-comments').setup ()

  map ('\\st', function ()
    Snacks.picker.todo_comments ()
  end, 'Todo')

  map ('\\sT', function ()
    Snacks.picker.todo_comments ({ keywords = { 'TODO', 'FIX', 'FIXME' } })
  end, 'Todo/Fix/Fixme')
end)
