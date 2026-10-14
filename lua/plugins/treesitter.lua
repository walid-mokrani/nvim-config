return {
  'nvim-treesitter/nvim-treesitter',
  -- Not `:TSUpdate` — that command returns before the async update finishes,
  -- so lazy marks the build done and the parsers stay on the old grammar.
  build = function()
    require('nvim-treesitter').update():wait(300000)
  end,
  config = function()
    require('nvim-treesitter').install({
      'bash',
      'c',
      'css',
      'dart',
      'diff',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'rust',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    })

    -- Enable treesitter-based highlighting and indentation (built-in)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
