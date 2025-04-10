local map = require ('util').map

local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'kdheepak/lazygit.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  })

  map ('<leader>gl', '<cmd>LazyGit<cr>', 'LazyGit')
end)
