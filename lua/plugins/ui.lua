-- which-key's default key labels are Nerd Font glyphs; without one, use text
local function text_key_labels()
  local labels = {}
  for _, key in ipairs { 'Up', 'Down', 'Left', 'Right', 'CR', 'Esc', 'ScrollWheelDown', 'ScrollWheelUp', 'NL', 'BS', 'Space', 'Tab' } do
    labels[key] = '<' .. key .. '> '
  end
  for _, mod in ipairs { 'C', 'M', 'D', 'S' } do
    labels[mod] = '<' .. mod .. '-…> '
  end
  for i = 1, 12 do
    labels['F' .. i] = '<F' .. i .. '>'
  end
  return labels
end

return {
  -- Popup showing pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or text_key_labels(),
      },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>l', group = '[L]SP' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
      },
    },
  },

  -- Statusline (from mini.nvim)
  {
    'nvim-mini/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Show line:column instead of the default (which includes line count)
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
