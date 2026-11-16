return {
  'folke/tokyonight.nvim',
  priority = 1000, -- load before other start plugins
  config = function()
    require('tokyonight').setup { styles = { comments = { italic = false } } }
    vim.cmd.colorscheme 'tokyonight'
  end,
}
