return {
  dir = '~/Development/codewise/plugins/nvim',
  name = 'codewise.nvim',
  lazy = true,
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('codewise').setup {
      search_mode = 'hybrid',
      daemon_idle_timeout = 60,
      exclude_tests = true,
      reranker = 'fast',

      telescope_opts = {
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.95,
          height = 0.95,
          preview_height = 0.6,
          prompt_position = 'bottom',
        },
      },
    }
  end,
  keys = {
    { '<leader>Ck', '<cmd>CodewiseSearchKeyword<CR>', desc = 'Search (keyword)' },
    { '<leader>Ch', '<cmd>CodewiseSearchHybrid<CR>', desc = 'Search (hybrid)' },
    { '<leader>Cs', '<cmd>CodewiseSearchSemantic<CR>', desc = 'Search (semantic)' },
    { '<leader>Cw', '<cmd>CodewiseSearchCursor<CR>', desc = 'Search word' },
    { '<leader>Co', '<cmd>CodewiseParse<CR>', desc = 'File outline' },
    { '<leader>Ci', '<cmd>CodewiseIndex --incremental<CR>', desc = 'Index project' },
    { '<leader>CI', '<cmd>CodewiseIndex --force<CR>', desc = 'Index project (force)' },
    { '<leader>Cp', '<cmd>CodewiseProjectList<CR>', desc = 'Projects' },
  },
}
