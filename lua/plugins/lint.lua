local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'mfussenegger/nvim-lint',
    depends = {
      'rshkarin/mason-nvim-lint',
    },
  })

  local lint = require ('lint')

  lint.linters_by_ft = {
    lua = { 'selene' },
    fish = { 'fish' },
  }

  require ('mason-nvim-lint').setup ({
    ignore_install = { 'fish' },
  })

  vim.api.nvim_create_autocmd ({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = vim.api.nvim_create_augroup ('lint', { clear = true }),
    callback = function ()
      if vim.opt_local.modifiable:get () then
        lint.try_lint ()
      end
    end,
  })
end)
