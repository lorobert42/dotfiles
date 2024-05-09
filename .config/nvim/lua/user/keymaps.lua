-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^', {desc = 'Go to line start'})
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_', {desc = 'Go to line end'})
vim.keymap.set('n', '<C-a>', ':keepjumps normal! ggVG<cr>', {desc = 'Select all'})

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, '<C-c>', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, '<C-v>', '"+p', {desc = 'Paste from clipboard'})

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x', {desc = 'Delete without altering register'})
vim.keymap.set({'n', 'x'}, 'X', '"_d', {desc = 'Delete without altering register'})

-- Commands
vim.keymap.set({'n', 'v', 'i'}, '<C-s>', '<esc><cmd>update<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>', {desc = 'Close current buffer'})
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>', {desc = 'Go to buffer #'})
