return {
  cmd = { 'lua-language-server' },
  on_init = function (client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath ('config')
        and (vim.uv.fs_stat (path .. '/.luarc.json') or vim.uv.fs_stat (path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend ('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      completion = {
        callSnippeet = 'Replace',
      },
      diagnostics = {
        globals = { 'MiniDeps', 'Snacks', 'vim' },
        disable = {
          'missing-fields',
        },
      },
      hint = {
        enable = true,
      },
      workspace = { checkThirdParty = 'Disable' },
    },
  },
}
