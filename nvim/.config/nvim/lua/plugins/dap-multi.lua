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
    end,
  },
  {
    -- Python debugging
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'python',
    config = function()
      -- Use debugpy from Mason if available, otherwise system Python
      local debugpy_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
      if vim.fn.filereadable(debugpy_path) == 0 then
        debugpy_path = 'python'
      end
      require('dap-python').setup(debugpy_path)

      local dap = require 'dap'
      -- Add custom Python configurations
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Launch with arguments',
        program = '${file}',
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'attach',
        name = 'Attach to running process',
        connect = function()
          local host = vim.fn.input 'Host [127.0.0.1]: '
          host = host ~= '' and host or '127.0.0.1'
          local port = tonumber(vim.fn.input 'Port [5678]: ') or 5678
          return { host = host, port = port }
        end,
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = '${workspaceFolder}/manage.py',
        args = { 'runserver', '--noreload' },
        django = true,
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Flask',
        module = 'flask',
        env = {
          FLASK_APP = 'app.py',
          FLASK_DEBUG = '1',
        },
        args = { 'run', '--no-debugger', '--no-reload' },
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'pytest: Current file',
        module = 'pytest',
        args = { '${file}', '-v' },
      })
    end,
  },
  {
    -- Rust debugging via codelldb (used by rustaceanvim)
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- Configure codelldb adapter for Rust
      local codelldb_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
      local liblldb_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'

      -- Check for Linux path if macOS path doesn't exist
      if vim.fn.filereadable(liblldb_path) == 0 then
        liblldb_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.so'
      end

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path,
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = 'Launch (with args)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' ')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = 'Attach to process',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }

      -- DAP keymaps (shared across all languages)
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
      vim.keymap.set('n', '<leader>dl', function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end, { desc = 'Debug set log point' })
      vim.keymap.set('n', '<leader>dc', function()
        require('dap').run_to_cursor()
      end, { desc = 'Debug run to cursor' })
      vim.keymap.set('n', '<leader>dq', function()
        require('dap').terminate()
      end, { desc = 'Debug terminate' })
      vim.keymap.set('n', '<leader>dr', function()
        require('dap').repl.open()
      end, { desc = 'Debug open REPL' })
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
