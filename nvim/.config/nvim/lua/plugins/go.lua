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
      }

      -- Key mappings
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- Go-specific mappings (nested under code namespace: <leader>cg)
      map('n', '<leader>cD', '<cmd>GoInstallDeps<CR>', 'Install dependencies')
      map('n', '<leader>Ta', '<cmd>GoTest<CR>', 'Test all (go)')
      map('n', '<leader>Tf', '<cmd>GoTestFunc<CR>', 'Test function (go)')
      map('n', '<leader>cs', '<cmd>GoFillStruct<CR>', 'Fill struct')
      map('n', '<leader>ca', '<cmd>GoAddTag<CR>', 'Add tags')
      map('n', '<leader>cx', '<cmd>GoRmTag<CR>', 'Delete/remove tags')
      map('n', '<leader>cI', '<cmd>GoImport<CR>', 'Import packages')
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
