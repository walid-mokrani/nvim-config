-- Merged over nvim-lspconfig's lsp/lua_ls.lua (see :h lsp-config-merge).
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
