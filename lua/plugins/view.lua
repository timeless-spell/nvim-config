local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'OXY2DEV/helpview.nvim',
  })

  add ({
    source = 'OXY2DEV/markview.nvim',
  })

  require ('helpview').setup ({
    preview = {
      icon_provider = 'mini',
    },
  })

  require ('markview').setup ({
    preview = {
      icon_provider = 'mini',
    },
  })
end)
