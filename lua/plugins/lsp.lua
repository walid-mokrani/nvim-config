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
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- Overrides the built-in grr with the Telescope picker. Other defaults
          -- (grn rename, gra code action, gri implementation, K hover) are kept.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      vim.lsp.config('*', { capabilities = capabilities })

      -- Language servers to run (nvim-lspconfig names)
      vim.lsp.enable {
        'rust_analyzer', -- from rustup, so it matches the active toolchain
        'lua_ls',
        'bashls',
      }

      -- Tools Mason installs (Mason package names)
      require('mason-tool-installer').setup {
        ensure_installed = {
          'lua-language-server',
          'bash-language-server',
          'stylua', -- formatter (conform)
          'sql-formatter', -- formatter (conform)
        },
      }
    end,
  },
}
