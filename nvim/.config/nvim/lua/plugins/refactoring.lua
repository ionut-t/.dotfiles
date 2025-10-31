return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {}

    -- Keymaps for refactoring
    vim.keymap.set('x', '<leader>re', function()
      require('refactoring').refactor 'Extract Function'
    end, { desc = '[R]efactor [E]xtract Function' })

    vim.keymap.set('x', '<leader>rf', function()
      require('refactoring').refactor 'Extract Function To File'
    end, { desc = '[R]efactor Extract Function to [F]ile' })

    vim.keymap.set('x', '<leader>rv', function()
      require('refactoring').refactor 'Extract Variable'
    end, { desc = '[R]efactor Extract [V]ariable' })

    vim.keymap.set('n', '<leader>rI', function()
      require('refactoring').refactor 'Inline Function'
    end, { desc = '[R]efactor [I]nline Function' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
      require('refactoring').refactor 'Inline Variable'
    end, { desc = '[R]efactor [I]nline Variable' })

    vim.keymap.set('n', '<leader>rb', function()
      require('refactoring').refactor 'Extract Block'
    end, { desc = '[R]efactor Extract [B]lock' })

    vim.keymap.set('n', '<leader>rbf', function()
      require('refactoring').refactor 'Extract Block To File'
    end, { desc = '[R]efactor Extract [B]lock to [F]ile' })

    -- Prompt for refactor
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      require('refactoring').select_refactor()
    end, { desc = '[R]efacto[r] - Select from menu' })
  end,
}
