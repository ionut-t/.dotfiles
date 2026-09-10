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
        sql = { 'sqlfluff' },
        terraform = { 'terraform_fmt' },
        toml = { 'taplo' },
      },
      formatters = {
        -- sqlfluff both formats and lints, so `<leader>cf` output is lint-clean by
        -- construction. sql-formatter indented 2 spaces while sqlfluff's LT02 wants
        -- 4, so every formatted file kept warning. `format` only touches layout --
        -- it leaves keyword casing, goose annotations and `$$` bodies alone.
        -- require_cwd is off so it still runs in repos without a `.sqlfluff`.
        sqlfluff = {
          args = { 'format', '--dialect=postgres', '-' },
          require_cwd = false,
          -- `format` exits 1 on any violation it cannot auto-fix (a long line in a
          -- $$ body, say) even though stdout holds correctly formatted SQL, which
          -- conform would otherwise report as "Formatter failed". Leftover findings
          -- are nvim-lint's to surface. Conform ignores empty output, so the buffer
          -- is left alone if sqlfluff genuinely fails.
          exit_codes = { 0, 1 },
        },
      },
      format_on_save = function()
        if vim.g.format_on_save_enabled then
          return {
            timeout_ms = timeout_ms,
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
