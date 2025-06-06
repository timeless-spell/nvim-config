local later = MiniDeps.later
--
-- MiniBufremove
-- :h mini.bufremove
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
--
later (function ()
  require ('mini.bufremove').setup ()
end)
