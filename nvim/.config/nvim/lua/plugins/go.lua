return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      'mason-lspconfig.nvim',
    },
  },

  -- Go-specific plugins
  {
    'ray-x/go.nvim',
    version = '*', -- Use latest stable version
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        -- Gopls configuration
        lsp_cfg = false, -- we configure gopls via lspconfig

        -- Format on save
        gofmt = 'gofumpt', -- use gofumpt for enhanced formatting

        -- Test configuration
        test_runner = 'go', -- use go test
        run_in_floaterm = true,

        -- Additional features
        dap_debug = true,
        dap_debug_gui = true,

        -- Customize icons (optional)
        icons = { breakpoint = '🔴', currentpos = '👉' },

        -- Auto-format and import on save
        lsp_inlay_hints = {
          enable = true,
          -- show_parameter_hints = true,
          parameter_hints_prefix = ' ',
          other_hints_prefix = ' ',
        },
      }

      -- Format on save
      local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          require('go.format').gofmt()
        end,
        group = format_sync_grp,
      })

      -- Key mappings
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- Go-specific mappings (nested under code namespace: <leader>cg)
      map('n', '<leader>cgd', '<cmd>GoInstallDeps<CR>', 'Go install dependencies')
      map('n', '<leader>cgt', '<cmd>GoTest<CR>', 'Go test')
      map('n', '<leader>cgtf', '<cmd>GoTestFunc<CR>', 'Go test function')
      map('n', '<leader>cgr', '<cmd>GoRun<CR>', 'Go run')
      map('n', '<leader>cgf', '<cmd>GoFillStruct<CR>', 'Go fill struct')
      map('n', '<leader>cga', '<cmd>GoAddTag<CR>', 'Go add tags')
      map('n', '<leader>cgx', '<cmd>GoRmTag<CR>', 'Go delete/remove tags')
      map('n', '<leader>cgI', '<cmd>GoImport<CR>', 'Go import packages')
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Optional but recommended plugins
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'go', 'gomod', 'gowork', 'gosum' },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
