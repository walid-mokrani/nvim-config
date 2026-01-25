return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },

  -- Claude Code
  {
    'greggh/claude-code.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('claude-code').setup {
        window = {
          position = 'vertical',
        },
        keymaps = {
          toggle = {
            normal = '<C-\\>',
            terminal = '<C-\\>',
          },
        },
      }

      -- Claude Code keymaps (using plugin commands for proper window management)
      vim.keymap.set('n', '<leader>Ac', '<cmd>ClaudeCode<CR>', { desc = 'Claude new session' })
      vim.keymap.set('n', '<leader>Ar', '<cmd>ClaudeCodeResume<CR>', { desc = 'Claude [r]esume' })
      vim.keymap.set('n', '<leader>Ao', '<cmd>ClaudeCodeContinue<CR>', { desc = 'Claude c[o]ntinue' })
      vim.keymap.set('n', '<leader>At', '<cmd>ClaudeCodeToggle<CR>', { desc = 'Claude [t]oggle window' })
    end,
  },
}
