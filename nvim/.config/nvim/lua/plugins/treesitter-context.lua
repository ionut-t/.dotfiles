return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesitter-context').setup {
      enable = true,
      max_lines = 3, -- How many lines the context window should span
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded
      mode = 'cursor', -- 'cursor' or 'topline'
      separator = nil, -- Use a string like '-' to add a separator line
      zindex = 20,
    }

    -- Set up keymap for jumping to context
    -- Note: Toggle is handled by snacks.nvim (<leader>uc)
    vim.keymap.set('n', '[C', function()
      require('treesitter-context').go_to_context()
    end, { desc = 'Go to context' })
  end,
}
