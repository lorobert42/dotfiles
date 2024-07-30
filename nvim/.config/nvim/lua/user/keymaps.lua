-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, 'gh', '^', {desc = 'Go to line start'})
vim.keymap.set({'n', 'x', 'o'}, 'gl', 'g_', {desc = 'Go to line end'})
vim.keymap.set('n', '<C-a>', ':keepjumps normal! ggVG<cr>', {desc = 'Select all'})

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, '<C-c>', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, '<C-v>', '"+p', {desc = 'Paste from clipboard'})

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x', {desc = 'Delete without altering register'})
vim.keymap.set({'n', 'x'}, 'X', '"_d', {desc = 'Delete without altering register'})

-- Commands
vim.keymap.set({'n', 'v', 'i'}, '<C-s>', '<esc><cmd>update<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>bl', '<cmd>bnext<cr>', {desc = 'Go to next buffer'})
vim.keymap.set('n', '<leader>bh', '<cmd>bprevious<cr>', {desc = 'Go to previous buffer'})
