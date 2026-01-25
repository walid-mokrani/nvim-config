return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file [e]xplorer' },
    { '<leader>E', '<cmd>NvimTreeFindFile<CR>', desc = 'Find file in [E]xplorer' },
  },
  opts = {
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    view = {
      width = 35,
    },
    renderer = {
      icons = {
        show = {
          file = vim.g.have_nerd_font,
          folder = vim.g.have_nerd_font,
          folder_arrow = vim.g.have_nerd_font,
          git = vim.g.have_nerd_font,
        },
      },
    },
    update_focused_file = {
      enable = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}
