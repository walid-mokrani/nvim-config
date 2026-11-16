-- Global keymaps. Plugin keymaps live in their plugin spec;
-- diagnostic keymaps live in config/diagnostics.lua.

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Leave terminal mode (default is <C-\><C-n>). Terminal mode deliberately has
-- no <C-hjkl> window maps: shells use those keys (clear, backspace, kill line).
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>bd!<CR>', { desc = 'Force close buffer' })
