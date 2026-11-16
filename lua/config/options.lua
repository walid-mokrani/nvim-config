-- See `:help option-list`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false -- mode is shown in the statusline

-- Sync with the OS clipboard; deferred because the provider lookup slows startup
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive search unless \C or a capital letter is used
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250 -- CursorHold delay (LSP document highlight)
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- live preview of :substitute
vim.o.cursorline = true
vim.o.scrolloff = 10

-- Disable unused remote-plugin providers (Python provider stays enabled via pynvim)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
