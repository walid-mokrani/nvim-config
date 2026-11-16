-- Merged over nvim-lspconfig's lsp/rust_analyzer.lua (see :h lsp-config-merge).
-- The binary comes from rustup (`rustup component add rust-analyzer`), not Mason.
---@type vim.lsp.Config
return {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        buildScripts = { enable = true },
      },
      checkOnSave = true,
      check = {
        command = 'clippy',
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
