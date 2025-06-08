local add, later = MiniDeps.add, MiniDeps.later

later (function ()
  add ({
    source = 'stevearc/conform.nvim',
  })

  require ('conform').setup ({
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_after_save = {
      lsp_format = 'fallback',
    },
  })

  vim.api.nvim_create_user_command ('Format', function (args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines (0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len () },
      }
    end
    require ('conform').format ({ async = true, lsp_fallback = true, range = range })
  end, { range = true })

  vim.keymap.set ('n', '<leader>bf', '<cmd>Format<cr>', { desc = 'Format Buffer' })
end)
