return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    -- Test adapters
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-go',
  },
  keys = {
    { '<leader>Tn', '<cmd>lua require("neotest").run.run()<cr>', desc = 'Test nearest' },
    { '<leader>Tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', desc = 'Test file' },
    {
      '<leader>Ta',
      '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<cr>',
      desc = 'Test all',
    },
    { '<leader>Ts', '<cmd>lua require("neotest").summary.toggle()<cr>', desc = 'Test summary' },
    { '<leader>To', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', desc = 'Test output' },
    { '<leader>TO', '<cmd>lua require("neotest").output_panel.toggle()<cr>', desc = 'Test output panel' },
    { '<leader>Td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>', desc = 'Test debug' },
    { '<leader>TS', '<cmd>lua require("neotest").run.stop()<cr>', desc = 'Test stop' },
    { '<leader>Tw', '<cmd>lua require("neotest").watch.toggle()<cr>', desc = 'Test watch' },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
          python = function()
            -- Use activated virtual environment or system python
            local venv = vim.env.VIRTUAL_ENV
            if venv then
              return venv .. '/bin/python'
            end
            return 'python3'
          end,
        },
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        },
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      output = {
        enabled = true,
        open_on_run = false,
      },
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        passed = '',
        running = '',
        failed = '',
        skipped = '',
        unknown = '',
      },
    }
  end,
}
