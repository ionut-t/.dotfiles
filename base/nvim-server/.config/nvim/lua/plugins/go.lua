return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason.nvim', 'mason-lspconfig.nvim' },
  },

  {
    'ray-x/go.nvim',
    version = '*',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        lsp_cfg = false,
        textobjects = false,
        gofmt = 'gofumpt',
        test_runner = 'go',
        run_in_floaterm = false,
        dap_debug = false,
        dap_debug_gui = false,
      }

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

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
    build = ':lua require("go.install").update_all_sync()',
  },
}
