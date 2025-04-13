local add, now = MiniDeps.add, MiniDeps.now

now (function ()
  add ({
    source = 'saghen/blink.cmp',
    depends = {
      'rafamadriz/friendly-snippets',
      'MahanRahmati/blink-nerdfont.nvim',
      'moyiz/blink-emoji.nvim',
      'mikavilpas/blink-ripgrep.nvim',
      'Kaiser-Yang/blink-cmp-git',
      'brenoprata10/nvim-highlight-colors',
    },
    checkout = 'v1.1.0',
  })

  require ('nvim-highlight-colors').setup ()

  local blink = require ('blink.cmp')

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

    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'nerdfont', 'emoji', 'ripgrep', 'git', 'lazydev' },
      providers = {
        nerdfont = {
          module = 'blink-nerdfont',
          name = 'Nerd Fonts',
          score_offset = 15,
          opts = { insert = true },
        },
        emoji = {
          module = 'blink-emoji',
          name = 'Emoji',
          score_offset = 15,
          opts = { insert = true },
        },
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {},
          transform_items = function (_, items)
            for _, item in ipairs (items) do
              item.labelDetails = {
                description = '(rg)',
              }
            end
            return items
          end,
        },
        git = {
          module = 'blink-cmp-git',
          name = 'Git',
          enabled = function ()
            return vim.tbl_contains ({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
          end,
          opts = {
            -- options for the blink-cmp-git
          },
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  })
end)
