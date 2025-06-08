local modules = {
  -- Appearance
  'nightfox',
  'cyberdream',
  'lualine',
  'mini_icons',
  'mini_starter',
  'highlight_chunk',
  -- Pickers
  'telescope',
  'mini_pick',
  'fzf',
  -- Editor
  'view',
  'autotag',
  'flash',
  'spider',
  'yanky',
  'substitute',
  'mini_ai',
  'mini_comment',
  'mini_surround',
  'mini_bufremove',
  'mini_extra',
  'mini_move',
  'mini_files',
  'snacks',
  'whichkey',
  'guess_indent',
  'todo_comments',
  'resession',
  -- LSP
  'blink',
  'lazydev',
  'lint',
  'conform',
  'dap',
  'treesitter',
  'trouble',
  'aerial',
  'endhints',
  -- Git
  'gitsigns',
  'lazygit',
  'neogit',
}

for _, module in ipairs (modules) do
  pcall (require, 'plugins.' .. module)
end
