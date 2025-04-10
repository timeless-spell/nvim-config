return {
  cmd = { 'lua-language-server' },
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
