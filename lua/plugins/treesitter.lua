return {
  'nvim-treesitter/nvim-treesitter',
  -- Not `:TSUpdate` — that command returns before the async update finishes,
  -- so lazy marks the build done and the parsers stay on the old grammar.
  build = function()
    require('nvim-treesitter').update():wait(300000)
  end,
  config = function()
    require('nvim-treesitter').install {
      'bash',
      'c',
      'dart',
      'diff',
      'html',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'rust',
      'sql',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    }

    -- Built-in treesitter highlighting, plus nvim-treesitter's indentation
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
