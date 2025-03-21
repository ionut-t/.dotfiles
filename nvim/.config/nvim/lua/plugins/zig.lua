return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('lspconfig').zls.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_attach = function(client, bufnr)
        -- Optional: Set up key mappings here if not defined globally
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
      end,
    }
  end,
}
