return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest', -- Vitest adapter
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require('neotest-vitest')({
          -- Filter dirs when searching for test files
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
          -- Detect Angular .spec.ts files as test files
          is_test_file = function(file_path)
            -- Angular uses .spec.ts pattern
            if string.match(file_path, '%.spec%.ts$') then
              return true
            end
            -- Also support standard Vitest patterns
            if string.match(file_path, '%.test%.ts$') then
              return true
            end
            return false
          end,
        }),
      },
    }
  end,
  keys = {
    { '<leader>Tt', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>Tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run test file' },
    { '<leader>Tw', function() require('neotest').run.run({ vitestCommand = 'vitest --watch' }) end, desc = 'Run watch mode' },
    { '<leader>Ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
    { '<leader>To', function() require('neotest').output.open({ enter = true }) end, desc = 'Show test output' },
    { '<leader>Tp', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
  },
}
