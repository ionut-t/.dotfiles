return {
  -- Better Python indentation
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },

  -- Docstring generation
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('neogen').setup {
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = 'google',
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>ng', function()
        require('neogen').generate()
      end, { desc = 'Neogen generate docstring' })
    end,
  },
}
