local add, later = MiniDeps.add, MiniDeps.later

--
-- nvim-jdtls
-- :h jdtls
-- Java language server support
-- https://github.com/mfussenegger/nvim-jdtls
--
later (function ()
  add ({
    source = 'mfussenegger/nvim-jdtls',
  })
end)
