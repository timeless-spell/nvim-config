local add, later = MiniDeps.add, MiniDeps.later
--
--  MiniComment
-- :h mini.comment
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
--
later (function ()
  add ({
    source = 'JoosepAlviste/nvim-ts-context-commentstring',
  })

  require ('mini.comment').setup ({
    options = {
      custom_commentstring = function ()
        return require ('ts_context_commentstring').calculate_commentstring () or vim.bo.commentstring
      end,
    },
  })
end)
