local timeout_ms = 2500

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format {
          lsp_fallback = true,
          async = false,
          timeout_ms = timeout_ms,
        }
      end,
      mode = { 'n', 'v' },
      desc = 'Code format',
    },
    {
      '<leader>uf',
      '<cmd>FormatToggle<cr>',
      desc = 'Toggle format on save',
    },
  },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },
        lua = { 'stylua' },
        go = { 'gofumpt', 'goimports' },
        python = { 'ruff_format' },
        shell = { 'shfmt' },
        sql = { 'sql_formatter' },
        toml = { 'taplo' },
      },
      -- sql-formatter found via PATH (mason bin or system install)
      format_on_save = function()
        if vim.g.format_on_save_enabled then
          return {
            timeout_ms = timeout_ms,
            lsp_fallback = true,
          }
        end
      end,
    }

    vim.g.format_on_save_enabled = true
    vim.api.nvim_create_user_command('FormatToggle', function()
      vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
      if vim.g.format_on_save_enabled then
        vim.notify 'Format on save enabled'
      else
        vim.notify 'Format on save disabled'
      end
    end, {})
  end,
}
