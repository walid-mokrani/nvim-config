local pick = require 'config.pick'

-- Buffer-local LSP keymaps. Neovim's defaults are kept: grn rename, gra code
-- action, gri implementation, grt type definition, K hover (see :h lsp-defaults).
local function set_keymaps(bufnr)
  local function map(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  map('gd', pick 'lsp_definitions', '[G]oto [D]efinition')
  map('grr', pick 'lsp_references', '[G]oto [R]eferences') -- Telescope instead of the quickfix default
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('<leader>D', pick 'lsp_type_definitions', 'Type [D]efinition')
  map('<leader>ds', pick 'lsp_document_symbols', '[D]ocument [S]ymbols')
  map('<leader>ws', pick 'lsp_dynamic_workspace_symbols', '[W]orkspace [S]ymbols')
  map('<leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens')
  map('<leader>lr', '<cmd>LspRestart<CR>', '[L]SP [R]estart')
end

-- Highlight references to the symbol under the cursor. One augroup per buffer,
-- so a second attaching client doesn't register the autocmds twice.
local function highlight_group_name(bufnr)
  return 'user-lsp-highlight-' .. bufnr
end

local function enable_document_highlight(bufnr)
  local group = vim.api.nvim_create_augroup(highlight_group_name(bufnr), { clear = true })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = bufnr,
    group = group,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = bufnr,
    group = group,
    callback = vim.lsp.buf.clear_references,
  })
end

local function on_attach(event)
  local bufnr = event.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  set_keymaps(bufnr)
  if not client then
    return
  end

  if client:supports_method('textDocument/documentHighlight', bufnr) then
    enable_document_highlight(bufnr)
  end

  if client:supports_method('textDocument/inlayHint', bufnr) then
    -- Inferred types and parameter names are most useful in Rust. This lives
    -- here rather than in after/lsp/rust_analyzer.lua because an on_attach
    -- there would replace nvim-lspconfig's (which adds :LspCargoReload).
    if client.name == 'rust_analyzer' then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
    vim.keymap.set('n', '<leader>th', function()
      local filter = { bufnr = bufnr }
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
    end, { buffer = bufnr, desc = 'LSP: [T]oggle Inlay [H]ints' })
  end
end

local function on_detach(event)
  local bufnr = event.buf
  local method = 'textDocument/documentHighlight'
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not (client and client:supports_method(method, bufnr)) then
    return
  end
  -- Keep highlighting if another attached client still provides it
  for _, other in ipairs(vim.lsp.get_clients { bufnr = bufnr, method = method }) do
    if other.id ~= client.id then
      return
    end
  end
  vim.lsp.util.buf_clear_references(bufnr)
  pcall(vim.api.nvim_del_augroup_by_name, highlight_group_name(bufnr))
end

return {
  -- Configures lua_ls for the Neovim runtime, this config and plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local group = vim.api.nvim_create_augroup('user-lsp', { clear = true })
      vim.api.nvim_create_autocmd('LspAttach', { group = group, callback = on_attach })
      vim.api.nvim_create_autocmd('LspDetach', { group = group, callback = on_detach })

      -- Completion capabilities are added by blink.cmp itself (vim.lsp.config('*')).
      -- Per-server settings live in after/lsp/<name>.lua and are merged over
      -- nvim-lspconfig's defaults (see :h lsp-config-merge).

      -- Language servers to run (nvim-lspconfig names)
      vim.lsp.enable {
        'rust_analyzer', -- from rustup, so it matches the active toolchain
        'dartls', -- ships with the Dart SDK (fvm)
        'lua_ls',
        'bashls',
        'marksman',
      }

      -- Tools Mason installs (Mason package names)
      require('mason-tool-installer').setup {
        ensure_installed = {
          'lua-language-server',
          'bash-language-server',
          'shellcheck', -- linter, used by bash-language-server
          'marksman',
          'stylua', -- formatter (conform)
          'sql-formatter', -- formatter (conform)
          'rumdl', -- Markdown formatter (conform)
        },
      }
    end,
  },
}
