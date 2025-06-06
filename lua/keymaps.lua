local map = require ('util').map

-- Sources current file/buffer
map ('<leader><space>s', '<cmd>source %<cr>', 'Source file/buffer')

-- Navigate buffers
map ('<a-a>', '<cmd>bprevious<cr>', 'Previous Buffer')
map ('<a-d>', '<cmd>bnext<cr>', 'Next Buffer')

-- Navigate splits
map ('<c-h>', '<c-w><c-h>', 'Move focus to the left window ')
map ('<c-l>', '<c-w><c-l>', 'Move focus to the right window ')
map ('<c-j>', '<c-w><c-j>', 'Move focus to the lower window ')
map ('<c-k>', '<c-w><c-k>', 'Move focus to the upper window ')

-- Clear highlight on search
map ('<esc>', '<cmd>nohlsearch<cr>', 'Clear highlight')

-- Delete current buffer
map ('<a-x>', '<cmd>bdelete<cr>', 'Delete buffer')

-- Modify Split Size
map ('<c-up>', '<CMD>resize -2<CR><cr>', 'Resize split Up')
map ('<c-down>', '<CMD>resize +2<CR><cr>', 'Resize split Down')
map ('<c-left>', '<CMD>vertical resize -2<cr>', 'Resize split Left')
map ('<c-right>', '<CMD>vertical resize +2<cr>', 'Resize split Right')
