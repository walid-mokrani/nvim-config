-- Diagnostics come from LSP and other sources, so they are configured here
-- rather than in the LSP plugin spec. ]d / [d (next/prev) are Neovim defaults.

vim.diagnostic.config {
  severity_sort = true,
  -- Inline messages are off by default since Neovim 0.11
  virtual_text = { spacing = 2, source = 'if_many' },
  float = { border = 'rounded', source = 'if_many' },
}

local function jump_error(count)
  return function()
    vim.diagnostic.jump { count = count, severity = vim.diagnostic.severity.ERROR }
  end
end

vim.keymap.set('n', ']e', jump_error(1), { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '[e', jump_error(-1), { desc = 'Go to previous [E]rror' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = '[C]ode [D]iagnostics (float)' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })
