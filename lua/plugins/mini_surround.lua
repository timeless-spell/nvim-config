local later = MiniDeps.later
--
-- MiniSurround
-- h: mini.surround
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
--
later (function ()
  require ('mini.surround').setup ({
    mappings = {
      add = 'msa',
      delete = 'msd',
      find = 'msf',
      find_left = 'msF',
      highlight = 'msh',
      replace = 'msr',
      update_n_lines = 'msn',

      suffix_last = 'l',
      suffix_next = 'n',
    },
  })
end)
