local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'folke/noice.nvim',
    depends = {
      'MunifTanjim/nui.nvim',
    },
    checkout = 'main',
  })

  require ('noice').setup ({
    views = {
      cmdline_popup = {
        border = {
          style = 'none',
          padding = { 2, 3 },
        },
        filter_options = {},
        win_options = {
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        },
      },
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = false,
        },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  })
end)
