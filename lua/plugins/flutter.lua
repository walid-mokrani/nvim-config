return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      fvm = true,
    }

    -- Flutter specific keymaps (requires telescope flutter extension)
    local flutter = require('telescope').extensions.flutter
    vim.keymap.set('n', '<leader>Fc', flutter.commands, { desc = '[F]lutter [C]ommands' })
    vim.keymap.set('n', '<leader>Ff', flutter.fvm, { desc = '[F]lutter [F]vm' })
  end,
}
