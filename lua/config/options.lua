local set, global = vim.opt, vim.g

--
-- Globals
--
global.mapleader = ' '
global.maplocalleader = ' '

--
-- Options
--
set.number = true
set.autoread = true
set.cursorline = true
set.relativenumber = true
set.undofile = true
set.mouse = 'a'
set.mousemoveevent = true
set.ignorecase = true
set.smartcase = true
set.signcolumn = 'yes'
set.updatetime = 250
set.splitright = true
set.splitbelow = true
set.inccommand = 'split'
set.termguicolors = true
set.breakindent = true
set.backup = false
set.showmode = false
set.list = true
set.listchars = { tab = '| ', eol = '󰘌' }
set.smartindent = true
set.clipboard = 'unnamedplus'
