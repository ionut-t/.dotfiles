return {
  {
    -- GitHub PRs and issues in Neovim: inline review comments, approve/request changes
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Octo',
    keys = {
      { '<leader>op', '<cmd>Octo pr list<cr>', desc = 'Octo PR list' },
      { '<leader>oo', '<cmd>Octo pr search<cr>', desc = 'Octo PR search' },
      { '<leader>oc', '<cmd>Octo pr checkout<cr>', desc = 'Octo PR checkout' },
      { '<leader>ok', '<cmd>Octo pr checks<cr>', desc = 'Octo PR checks' },
      { '<leader>or', '<cmd>Octo review start<cr>', desc = 'Octo review start' },
      { '<leader>oR', '<cmd>Octo review resume<cr>', desc = 'Octo review resume' },
      { '<leader>os', '<cmd>Octo review submit<cr>', desc = 'Octo review submit' },
      { '<leader>od', '<cmd>Octo review discard<cr>', desc = 'Octo review discard' },
      { '<leader>oi', '<cmd>Octo issue list<cr>', desc = 'Octo issue list' },
    },
    opts = {
      picker = 'telescope',
      use_diagnostics = false,
      -- The default gh token lacks the projects_v2 scope; silence the warning
      -- rather than requesting a scope none of these mappings need.
      suppress_missing_scope = { projects_v2 = true },
    },
  },
}
