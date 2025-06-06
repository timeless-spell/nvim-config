local now, later = MiniDeps.now, MiniDeps.later

--
-- MiniAi
-- :h mini.ai
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
--
later (function ()
  require ('mini.ai').setup ()
end)
