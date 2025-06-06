local map = require ('util').map

--
-- nvim-jdtls
--
local jdtls = require ('jdtls')
local jdtls_dap = require ('jdtls.dap')

--
-- JDTLS
--
local jdtls_path = vim.env.HOME .. '/local/java/eclipse.jdt.ls'
local jdtls_plugin = vim.fn.glob (jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_linux = jdtls_path .. '/config_linux'

--
-- Lombok
--
local lombok = jdtls_path .. '/lombok.jar'

--
-- Debug and test
--
local java_debug = vim.fn.glob (vim.env.HOME .. '/local/java/java-debug/com.microsoft.java.debug.plugin-*.jar', true)
local java_test = vim.fn.glob (vim.env.HOME .. '/local/java/java-test/com.microsoft.java.test.plugin-*.jar', true)

local bundles = {
  java_debug,
}
vim.list_extend (bundles, vim.split (java_test, '\n'))

-- Get current working project name
local project_name = vim.fn.fnamemodify (vim.fn.getcwd (), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/.cache/jdtls/workspace' .. project_name

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. lombok,
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    jdtls_plugin,
    '-configuration',
    config_linux,
    '-data',
    workspace_dir,
  },
  root_dir = vim.fs.root (0, { '.git', 'mvnw', 'pom.xml', 'build.gradle' }),
  settings = {
    java = {
      home = vim.env.HOME .. '/.local/share/mise/installs/java/temurin-21',
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          -- {
          --   name = 'JavaSE-11',
          --   path = '/usr/lib/jvm/temurin-11-jdk-amd64',
          -- },
          {
            name = 'JavaSE-17',
            path = vim.env.HOME .. '/.local/share/mise/installs/java/temurin-17',
          },
          {
            name = 'JavaSE-21',
            path = vim.env.HOME .. '/.local/share/mise/installs/java/temurin-21',
          },
        },
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      format = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        importOrder = {
          'java',
          'javax',
          'com',
          'org',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
      },
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  capabilities = require ('blink.cmp').get_lsp_capabilities (),
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

config['on_attach'] = function (client, bufnr)
  jdtls.setup_dap ({ hotcodereplace = 'auto' })
  jdtls_dap.setup_dap_main_class_configs ()

  map ('<leader>jo', "<cmd>lua require('jdtls').organize_imports()<cr>", '[JDTLS] Organize Imports')
  map ('<leader>je', "<cmd>lua require('jdtls').extract_variable()<cr>", '[JDTLS] Extract Variable')
  map ('<leader>je', "<cmd>lua require('jdtls').extract_variable(true)<cr>", '[JDTLS] Extract Variable', 'v')
  map ('<leader>jE', "<cmd>lua require('jdtls').extract_constant()<cr>", '[JDTLS] Extract Constant')
  map ('<leader>jE', "<cmd>lua require('jdtls').extract_constant(true)<cr>", '[JDTLS] Extract Constant', 'v')
  map ('<leader>jM', "<cmd>lua require('jdtls').extract_method(true)<cr>", '[JDTLS] Extract Method', 'v')
  map ('<leader>jt', "<cmd>lua require('jdtls').test_class()<cr>", '[JDTLS] Test Class')
  map ('<leader>jt', "<cmd>lua require('jdtls').test_nearest_method()<cr>", '[JDTLS] Test Nearest Method')
end

jdtls.start_or_attach (config)
