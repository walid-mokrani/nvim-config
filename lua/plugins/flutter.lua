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

    -- Flutter specific keymaps (deferred until telescope is available)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TelescopeLoaded',
      once = true,
      callback = function()
        local ok, telescope = pcall(require, 'telescope')
        if ok and telescope.extensions.flutter then
          local flutter = telescope.extensions.flutter
          vim.keymap.set('n', '<leader>Fc', flutter.commands, { desc = '[F]lutter [C]ommands' })
          vim.keymap.set('n', '<leader>Ff', flutter.fvm, { desc = '[F]lutter [F]vm' })
        end
      end,
    })

    -- Also set up keymaps immediately if telescope is already loaded
    vim.schedule(function()
      local ok, telescope = pcall(require, 'telescope')
      if ok then
        pcall(telescope.load_extension, 'flutter')
        if telescope.extensions.flutter then
          local flutter = telescope.extensions.flutter
          vim.keymap.set('n', '<leader>Fc', flutter.commands, { desc = '[F]lutter [C]ommands' })
          vim.keymap.set('n', '<leader>Ff', flutter.fvm, { desc = '[F]lutter [F]vm' })
        end
      end
    end)
  end,
}
