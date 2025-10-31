return {
  -- Python-specific tools and enhancements
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      require('venv-selector').setup {
        -- Auto select virtualenv
        auto_refresh = true,
        search_venv_managers = true,
        search_workspace = true,
        search = true,
        dap_enabled = true,

        -- Path patterns to search for virtual environments
        path = {
          '.venv',
          'venv',
          'env',
          '.env',
          '~/.virtualenvs',
          '~/.pyenv/versions',
        },

        -- Show notification when switching venv
        notify_user_on_activate = true,
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>', { desc = '[V]env [S]elect' })
      vim.keymap.set('n', '<leader>vc', '<cmd>VenvSelectCached<cr>', { desc = '[V]env Select [C]ached' })
    end,
  },

  -- Better Python indentation
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },

  -- Python debugging with DAP
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      -- Setup DAP for Python
      local dap_python = require 'dap-python'

      -- Try to find Python in common locations
      local python_path = vim.fn.exepath 'python3' or vim.fn.exepath 'python'
      if python_path ~= '' then
        dap_python.setup(python_path)
      end

      -- Test runner configurations
      dap_python.test_runner = 'pytest'

      -- Keymaps for debugging
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>dn', function()
        require('dap-python').test_method()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug [N]earest test method' }))

      vim.keymap.set('n', '<leader>df', function()
        require('dap-python').test_class()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug test [F]ile/class' }))

      vim.keymap.set('v', '<leader>ds', function()
        require('dap-python').debug_selection()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug [S]election' }))
    end,
  },

  -- DAP (Debug Adapter Protocol) core
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      -- Setup DAP UI
      dapui.setup()

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Keymaps for DAP
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug toggle [B]reakpoint' }))

      vim.keymap.set('n', '<leader>dc', function()
        dap.continue()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug [C]ontinue' }))

      vim.keymap.set('n', '<leader>di', function()
        dap.step_into()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug step [I]nto' }))

      vim.keymap.set('n', '<leader>do', function()
        dap.step_over()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug step [O]ver' }))

      vim.keymap.set('n', '<leader>dO', function()
        dap.step_out()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug step [O]ut' }))

      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.toggle()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug toggle [R]EPL' }))

      vim.keymap.set('n', '<leader>dl', function()
        dap.run_last()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug run [L]ast' }))

      vim.keymap.set('n', '<leader>du', function()
        dapui.toggle()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug toggle [U]I' }))

      vim.keymap.set('n', '<leader>dt', function()
        dap.terminate()
      end, vim.tbl_extend('force', opts, { desc = '[D]ebug [T]erminate' }))

      -- Breakpoint signs
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = '', linehl = '', numhl = '' })
    end,
  },

  -- DAP UI
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
  },

  -- Note: Neotest configuration moved to plugins/testing.lua for multi-language support

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
              annotation_convention = 'google', -- or "numpy", "reST"
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>ng', function()
        require('neogen').generate()
      end, { desc = '[N]eogen [G]enerate docstring' })
    end,
  },
}
