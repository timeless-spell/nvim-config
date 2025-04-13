vim.lsp.config ('*', {
  capabilities = require ('blink.cmp').get_lsp_capabilities (),
})

vim.lsp.enable ('luals')

vim.api.nvim_create_autocmd ('LspAttach', {
  group = vim.api.nvim_create_augroup ('lsp-attach', { clear = true }),
  callback = function (event)
    local map = function (keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set (mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map ('<leader>lgd', vim.lsp.buf.definition, '[G]oto Definition')
    map ('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map ('<leader>lgi', vim.lsp.buf.implementation, '[G]oto Implementation')
    map ('<leader>lgt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
    map ('<leader>lh', vim.lsp.buf.signature_help, '[S]ignature [H]elp')
    map ('<leader>lr', vim.lsp.buf.references, '[Re]ferences')
    map ('<leader>ln', vim.lsp.buf.rename, '[R]e[n]ame')
    map ('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map ('<leader>lw', vim.lsp.buf.workspace_symbol, '[W}orkspace [S]ymbol')
    map ('<leader>ld', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbol')

    local function client_supports_method (client, method, bufnr)
      return client:supports_method (method, bufnr)
    end

    local client = vim.lsp.get_client_by_id (event.data.client_id)
    if
      client and client_supports_method (client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup ('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd ({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd ({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd ('LspDetach', {
        group = vim.api.nvim_create_augroup ('lsp-detach', { clear = true }),
        callback = function (event2)
          vim.lsp.buf.clear_references ()
          vim.api.nvim_clear_autocmds ({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end

    if client and client_supports_method (client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map ('<leader>lt', function ()
        vim.lsp.inlay_hint.enable (not vim.lsp.inlay_hint.is_enabled ({ bufnr = event.buf }))
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.api.nvim_create_autocmd ('LspAttach', {
  group = vim.api.nvim_create_augroup ('telescope-lsp-attach', { clear = true }),
  callback = function (event)
    local builtin = require ('telescope.builtin')
    if not builtin then
      return
    else
      local map = function (keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set (mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map ('<leader>tld', function ()
        builtin.lsp_definitions ({ layout_config = { width = 0.95, height = 0.95 } })
      end, '[L]SP [D]efinitions')

      map ('<leader>tlr', function ()
        builtin.lsp_references ({
          layout_strategy = 'vertical',
          layout_config = { width = 0.95, height = 0.95 },
        })
      end, '[L]SP [R]eferences')

      map ('<leader>tlI', function ()
        builtin.lsp_implementations ({
          layout_strategy = 'vertical',
          layout_config = { width = 0.95, height = 0.95 },
        })
      end, '[L]SP [I]mplementation')

      map ('<leader>tlD', builtin.lsp_type_definitions, '[L]SP Type [D]efinition')

      map ('<leader>tlo', function ()
        builtin.lsp_document_symbols ({ layout_config = { width = 0.95, height = 0.95 } })
      end, '[L]SP [D]ocument Symbols')

      map ('<leader>tlw', function ()
        builtin.lsp_dynamic_workspace_symbols ({
          layout_strategy = 'vertical',
          layout_config = { width = 0.95, height = 0.95 },
        })
      end, '[L]SP [W]orkspace Symbols')
    end
  end,
})
