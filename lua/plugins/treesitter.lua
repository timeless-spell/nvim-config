local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'nvim-treesitter/nvim-treesitter',
    depends = { 'nvim-treesitter/nvim-treesitter-context' },
    hooks = {
      post_checkout = function ()
        vim.cmd ('TSUpdate')
      end,
    },
  })

  require ('nvim-treesitter.configs').setup ({
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'fish',
      'regex',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
  })

  require ('treesitter-context').setup ()
end)
