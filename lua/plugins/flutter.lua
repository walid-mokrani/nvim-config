return {
  'nvim-flutter/flutter-tools.nvim',
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      fvm = true,
    }

    local menu = require 'flutter-tools.menu'
    vim.keymap.set('n', '<leader>Fc', menu.commands, { desc = '[F]lutter [C]ommands' })
    vim.keymap.set('n', '<leader>Ff', menu.select_fvm, { desc = '[F]lutter [F]vm' })
  end,
}
