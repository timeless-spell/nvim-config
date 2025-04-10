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

--
-- [[ Lazydev ]]
--
later (function ()
  add ({
    source = 'folke/lazydev.nvim',
  })

  require ('lazydev').setup ({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
    integrations = {
      cmp = false,
      lspconfig = false,
    },
  })
end)

--
-- [[ Blink ]]
--
now (function ()
  add ({
    source = 'saghen/blink.compat',
    checkout = 'main',
  })

  add ({
    source = 'saghen/blink.cmp',
    depends = {
      'rafamadriz/friendly-snippets',
      'moyiz/blink-emoji.nvim',
      'mtoohey31/cmp-fish',
      'chrisgrieser/cmp-nerdfont',
      'brenoprata10/nvim-highlight-colors',
      'Kaiser-Yang/blink-cmp-git',
    },
    checkout = 'v1.1.0',
  })

  require ('nvim-highlight-colors').setup ({})

  local blink, compat = require ('blink.cmp'), require ('blink.compat')

  compat.setup ({ debug = true })

  blink.setup ({
    cmdline = {
      enabled = false,
    },
    completion = {
      list = {
        selection = {
          preselect = function (ctx)
            return ctx.mode ~= 'cmdline'
          end,
        },
      },
      menu = {
        max_height = 15,
        border = 'solid',
        winblend = 10,
        scrollbar = false,
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
            { 'source_name', gap = 1 },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function (ctx)
                local icon, _, _ = require ('mini.icons').get ('lsp', ctx.kind)
                if ctx.item.source_name == 'LSP' then
                  local color_item =
                    require ('nvim-highlight-colors').format (ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr then
                    icon = icon .. ' ' .. color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function (ctx)
                local _, highlight, _ = require ('mini.icons').get ('lsp', ctx.kind)
                if ctx.item.source_name == 'LSP' then
                  local color_item =
                    require ('nvim-highlight-colors').format (ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'solid' },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'git', 'emoji', 'fish', 'nerdfont', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        git = {
          module = 'blink-cmp-git',
          name = 'Git',
        },
        emoji = {
          module = 'blink-emoji',
          name = 'Emoji',
          score_offset = 15,
        },
        fish = {
          name = 'fish',
          module = 'blink.compat.source',
        },
        nerdfont = {
          name = 'nerdfont',
          module = 'blink.compat.source',
        },
      },
    },
  })
end)

later (function ()
  add ({
    source = 'chrisgrieser/nvim-lsp-endhints',
  })

  require ('lsp-endhints').setup ()
end)
