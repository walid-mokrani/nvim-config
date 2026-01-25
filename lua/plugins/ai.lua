return {
  -- GitHub Copilot (Lua rewrite)
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<M-l>',
          accept_word = '<M-k>',
          accept_line = '<M-j>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    },
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
            variants = {
              continue = '<leader>Ao',
              verbose = '<leader>Av',
            },
          },
        },
      }

      -- Claude Code keymaps (using plugin commands for proper window management)
      vim.keymap.set('n', '<leader>Ac', '<cmd>ClaudeCode<CR>', { desc = 'Claude new session' })
      vim.keymap.set('n', '<leader>Ar', '<cmd>ClaudeCodeResume<CR>', { desc = 'Claude [r]esume' })
      vim.keymap.set('n', '<leader>At', '<cmd>ClaudeCodeToggle<CR>', { desc = 'Claude [t]oggle window' })
    end,
  },
}
