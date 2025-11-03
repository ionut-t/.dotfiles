return {
  {
    -- TypeScript/JavaScript debugging
    'mxsdev/nvim-dap-vscode-js',
    dependencies = {
      'mfussenegger/nvim-dap',
      {
        'microsoft/vscode-js-debug',
        build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
      },
    },
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      local dap = require 'dap'
      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome (Angular)',
            url = 'http://localhost:4200',
            webRoot = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Debug Jest Tests',
            runtimeExecutable = 'node',
            runtimeArgs = {
              './node_modules/jest/bin/jest.js',
              '--runInBand',
            },
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
          },
        }
      end

      -- DAP UI keymaps
      vim.keymap.set('n', '<F5>', function()
        require('dap').continue()
      end, { desc = 'Debug start/continue' })
      vim.keymap.set('n', '<F10>', function()
        require('dap').step_over()
      end, { desc = 'Debug step over' })
      vim.keymap.set('n', '<F11>', function()
        require('dap').step_into()
      end, { desc = 'Debug step into' })
      vim.keymap.set('n', '<F12>', function()
        require('dap').step_out()
      end, { desc = 'Debug step out' })
      vim.keymap.set('n', '<leader>db', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Debug toggle breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug set conditional breakpoint' })
    end,
  },
  {
    -- Go debugging
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'go',
    config = function()
      require('dap-go').setup {
        dap_configurations = {
          {
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        delve = {
          path = 'dlv',
          initialize_timeout_sec = 20,
          port = '${port}',
          args = {},
        },
      }
    end,
  },
  {
    -- DAP UI for better debugging experience
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug toggle UI',
      },
      {
        '<leader>de',
        function()
          require('dapui').eval()
        end,
        mode = { 'n', 'v' },
        desc = 'Debug eval expression',
      },
    },
    opts = {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    },
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)

      -- Auto-open DAP UI when debugging starts
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
