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
          timeout_ms = 500,
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
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        html = { 'prettier' },
        htmlangular = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },
        graphql = { 'prettier' },
        handlebars = { 'prettier' },
        lua = { 'stylua' },
        go = { 'gofumpt', 'goimports' },
        python = { 'ruff_format' },
        shell = { 'shfmt' },
        sql = { 'sql-formatter' },
        terraform = { 'terraform_fmt' },
      },
      format_on_save = function()
        if vim.g.format_on_save_enabled then
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end
      end,
    }

    -- Toggle format on save (keymaps defined in keys spec above for lazy loading)
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
