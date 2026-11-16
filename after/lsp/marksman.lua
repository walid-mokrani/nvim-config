-- Merged over nvim-lspconfig's lsp/marksman.lua (see :h lsp-config-merge).
-- Drop the default 'markdown.mdx' filetype, which Neovim doesn't define
-- (it only triggers a :checkhealth warning).
---@type vim.lsp.Config
return {
  filetypes = { 'markdown' },
}
