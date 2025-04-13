---
--- Highlight when yanking (copying) text
---
vim.api.nvim_create_autocmd ('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup ('kickstart-highlight-yank', { clear = true }),
  callback = function ()
    vim.highlight.on_yank ()
  end,
})

-- NOTE: Weird workaround to stop blink.cmp cmdline source from freezing Neovim in WSL2.
vim.api.nvim_create_autocmd ('VimEnter', {
  desc = 'Disable Windows Path',
  group = vim.api.nvim_create_augroup ('disable-windows-path', { clear = true }),
  -- TODO: Refactor callback function
  callback = function ()
    local initial_path = vim.fn.getenv ('PATH')
    local pattern_starts = string.find (initial_path, '/mnt')
    local extracted_path = string.sub (initial_path, 1, pattern_starts - 2)
      .. ':/mnt/c/Users/Angju/scoop/apps/win32yank/current/'
    vim.fn.setenv ('PATH', extracted_path)
  end,
})
