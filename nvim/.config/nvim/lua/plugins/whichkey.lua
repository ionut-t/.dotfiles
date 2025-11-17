return {
  -- Hints keybinds
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    delay = 500,
    icons = {
      separator = '→',
      group = '+',
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.add {
      { '<leader>b', group = '+buffer' },
      { '<leader>c', group = '+code' },
      { '<leader>cg', group = '+go' },
      { '<leader>d', group = '+debug' },
      { '<leader>e', group = '+explorer' },
      { '<leader>f', group = '+file/find' },
      { '<leader>g', group = '+git' },
      { '<leader>h', group = '+hunks' },
      { '<leader>n', group = '+notes' },
      { '<leader>q', group = '+quit/session' },
      { '<leader>r', group = '+refactor' },
      { '<leader>s', group = '+search' },
      { '<leader>t', group = '+terminal' },
      { '<leader>T', group = '+test' },
      { '<leader>u', group = '+ui' },
      { '<leader>v', group = '+venv' },
      { '<leader>w', group = '+windows' },
      { '<leader>x', group = '+diagnostics/quickfix' },
      { 'm', group = '+marks' },
      { 'dm', group = '+delete marks' },
    }
  end,
}
