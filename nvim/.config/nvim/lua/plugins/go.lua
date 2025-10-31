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

      -- Go-specific mappings
      map('n', '<leader>gi', '<cmd>GoInstallDeps<CR>', 'Install Go Dependencies')
      map('n', '<leader>gt', '<cmd>GoTest<CR>', 'Run Go Tests')
      map('n', '<leader>gtf', '<cmd>GoTestFunc<CR>', 'Run Test Function')
      map('n', '<leader>gr', '<cmd>GoRun<CR>', 'Run Go Program')
      map('n', '<leader>gfs', '<cmd>GoFillStruct<CR>', 'Fill Struct')
      map('n', '<leader>gat', '<cmd>GoAddTag<CR>', 'Add Tags to Struct')
      map('n', '<leader>grm', '<cmd>GoRmTag<CR>', 'Remove Tags from Struct')
      map('n', '<leader>gim', '<cmd>GoImport<CR>', 'Import Packages')
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
