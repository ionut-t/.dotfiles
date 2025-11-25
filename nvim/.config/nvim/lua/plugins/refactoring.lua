return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>re',
      function()
        require('refactoring').refactor 'Extract Function'
      end,
      mode = 'x',
      desc = 'Refactor extract function',
    },
    {
      '<leader>rf',
      function()
        require('refactoring').refactor 'Extract Function To File'
      end,
      mode = 'x',
      desc = 'Refactor extract function to file',
    },
    {
      '<leader>rv',
      function()
        require('refactoring').refactor 'Extract Variable'
      end,
      mode = 'x',
      desc = 'Refactor extract variable',
    },
    {
      '<leader>rI',
      function()
        require('refactoring').refactor 'Inline Function'
      end,
      mode = 'n',
      desc = 'Refactor inline function',
    },
    {
      '<leader>ri',
      function()
        require('refactoring').refactor 'Inline Variable'
      end,
      mode = { 'n', 'x' },
      desc = 'Refactor inline variable',
    },
    {
      '<leader>rbe',
      function()
        require('refactoring').refactor 'Extract Block'
      end,
      mode = 'n',
      desc = 'Refactor block extract',
    },
    {
      '<leader>rbf',
      function()
        require('refactoring').refactor 'Extract Block To File'
      end,
      mode = 'n',
      desc = 'Refactor extract block to file',
    },
    {
      '<leader>rr',
      function()
        require('refactoring').select_refactor()
      end,
      mode = { 'n', 'x' },
      desc = 'Refactor select from menu',
    },
  },
  config = function()
    require('refactoring').setup {}
  end,
}
