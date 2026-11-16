return {
  'saghen/blink.cmp',
  -- Stable 1.x releases ship a prebuilt Rust fuzzy matcher (v2 is in development)
  version = '1.*',
  lazy = false, -- blink lazy-loads internally; loading at startup lets it register LSP capabilities before servers start
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- <C-n>/<C-p> select, <C-y> accept, <C-Space> open, <C-e> close,
      -- <C-b>/<C-f> scroll docs, <C-k> signature help
      preset = 'default',
      -- Jump forward/back inside an expanded snippet
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },
    -- LSP snippets are expanded with Neovim's built-in vim.snippet (blink's default).
    -- No 'snippets' source: there are no snippet files (add friendly-snippets to get some).
    signature = { enabled = true },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'buffer' },
      per_filetype = {
        sql = { 'dadbod', 'buffer' },
        mysql = { 'dadbod', 'buffer' },
        plsql = { 'dadbod', 'buffer' },
      },
      providers = {
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      },
    },
  },
}
