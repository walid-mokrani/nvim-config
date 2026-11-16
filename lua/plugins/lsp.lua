return {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- Defer requiring Telescope until the key is pressed (keeps it lazy-loaded)
          local tb = function(picker)
            return function()
              require('telescope.builtin')[picker]()
            end
          end

          map('gd', tb 'lsp_definitions', '[G]oto [D]efinition')
          -- Overrides the built-in grr with the Telescope picker. Other defaults
          -- (grn rename, gra code action, gri implementation, K hover) are kept.
          map('grr', tb 'lsp_references', '[G]oto [R]eferences')
          map('gI', tb 'lsp_implementations', '[G]oto [I]mplementation')
          map('<leader>D', tb 'lsp_type_definitions', 'Type [D]efinition')
          map('<leader>ds', tb 'lsp_document_symbols', '[D]ocument [S]ymbols')
          map('<leader>ws', tb 'lsp_dynamic_workspace_symbols', '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostics')
          map('<leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens')
          map('<leader>lr', '<cmd>LspRestart<CR>', '[L]SP [R]estart')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- Inferred types and parameter names are most useful in Rust
            if client.name == 'rust_analyzer' then
              vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
            end
            map('<leader>th', function()
              local filter = { bufnr = event.buf }
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Shared settings for every server. Per-server settings live in
      -- after/lsp/<name>.lua and are merged over nvim-lspconfig's defaults
      -- (see :h lsp-config-merge).
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

      -- Language servers to run (nvim-lspconfig names)
      vim.lsp.enable {
        'rust_analyzer', -- from rustup, so it matches the active toolchain
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
