return {
  -- Hints keybinds
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    delay = 500,
    icons = {
      separator = '➜',
      group = '',
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.add {
      { '<leader>b', group = 'Buffers', icon = '' },
      { '<leader>c', group = 'Code', icon = '' },
      { '<leader>d', group = 'Debug', icon = '' },
      { '<leader>e', group = 'Explore', icon = '' },
      { '<leader>f', group = 'Find', icon = '' },
      { '<leader>g', group = 'Git', icon = '' },
      { '<leader>h', group = 'Hunks', icon = '' },
      { '<leader>m', group = 'Harpoon', icon = '' },
      { '<leader>n', group = 'Notes', icon = '' },
      { '<leader>q', group = 'Quit', icon = '󰗼' },
      { '<leader>r', group = 'Refactor', icon = '󰑕' },
      { '<leader>s', group = 'Search', icon = '' },
      { '<leader>t', group = 'Terminal', icon = '' },
      { '<leader>T', group = 'Test', icon = '' },
      { '<leader>u', group = 'UI', icon = '' },
      { '<leader>v', group = 'Venv', icon = '' },
      { '<leader>w', group = 'Windows', icon = '' },
      { '<leader>x', group = 'Diagnostics', icon = '' },
      { '<leader>y', group = 'Yank path', icon = '' },
      { '<leader>-', group = 'Oil', icon = '' },
    }
  end,
}
