local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

--
-- [[ Mason ]]
--
now (function ()
  add ({
    source = 'williamboman/mason.nvim',
  })

  require ('mason').setup ({
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })
end)
