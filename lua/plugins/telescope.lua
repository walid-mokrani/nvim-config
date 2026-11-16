local pick = require 'config.pick'

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  keys = {
    { '<leader>sh', pick 'help_tags', desc = '[S]earch [H]elp' },
    { '<leader>sk', pick 'keymaps', desc = '[S]earch [K]eymaps' },
    { '<leader>sf', pick 'find_files', desc = '[S]earch [F]iles' },
    { '<leader>ss', pick 'builtin', desc = '[S]earch [S]elect Telescope' },
    { '<leader>sw', pick 'grep_string', desc = '[S]earch current [W]ord' },
    { '<leader>sg', pick 'live_grep', desc = '[S]earch by [G]rep' },
    { '<leader>sd', pick 'diagnostics', desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', pick 'resume', desc = '[S]earch [R]esume' },
    { '<leader>s.', pick 'oldfiles', desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader><leader>', pick 'buffers', desc = '[ ] Find existing buffers' },
    { '<leader>sc', pick 'commands', desc = '[S]earch [C]ommands' },
    {
      '<leader>/',
      pick('current_buffer_fuzzy_find', function()
        return require('telescope.themes').get_dropdown { winblend = 10, previewer = false }
      end),
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      pick('live_grep', { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }),
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      pick('find_files', function()
        return { cwd = vim.fn.stdpath 'config' }
      end),
      desc = '[S]earch [N]eovim files',
    },
  },
  init = function()
    -- telescope-ui-select replaces vim.ui.select once Telescope loads; until then,
    -- load Telescope on the first vim.ui.select call (e.g. code actions).
    local builtin_select = vim.ui.select
    local function lazy_select(...)
      require('lazy').load { plugins = { 'telescope.nvim' } }
      if vim.ui.select == lazy_select then
        vim.ui.select = builtin_select -- ui-select failed to load; use the built-in picker
      end
      return vim.ui.select(...)
    end
    vim.ui.select = lazy_select
  end,
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Extensions are optional (fzf-native needs `make`)
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end,
}
