return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js/html/css/json/yaml/markdown formatter
        'stylua', -- lua formatter
        -- Note: eslint_d removed due to high memory usage
        -- typescript-tools.nvim provides linting for TS/JS
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'gofumpt', -- Go formatter (stricter version of gofmt)
        'goimports', -- Go imports formatter
        'sql-formatter', -- SQL formatter
      },
      automatic_installation = true,
    }

    local sources = {
      -- Diagnostics/Linters
      diagnostics.checkmake,
      -- eslint_d removed - using typescript-tools.nvim for TS/JS linting

      -- Formatters
      -- TypeScript/JavaScript/React/Vue/Angular
      formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'css',
          'scss',
          'less',
          'html',
          'json',
          'jsonc',
          'yaml',
          'markdown',
          'markdown.mdx',
          'graphql',
          'handlebars',
        },
      },

      -- Lua
      formatting.stylua,

      -- Go
      formatting.gofumpt,
      formatting.goimports,

      -- Shell
      formatting.shfmt.with { args = { '-i', '4' } },

      -- SQL
      formatting.sql_formatter,

      -- Terraform
      formatting.terraform_fmt,

      -- Python (ruff handles both linting and formatting)
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    -- Global variable to track format-on-save state
    vim.g.format_on_save_enabled = true

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- Only format if globally enabled
              if vim.g.format_on_save_enabled then
                vim.lsp.buf.format { async = false }
              end
            end,
          })
        end
      end,
    }

    -- Keymap to toggle format-on-save
    vim.keymap.set('n', '<leader>uf', function()
      vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
      local status = vim.g.format_on_save_enabled and 'enabled' or 'disabled'
      vim.notify('Format on save ' .. status, vim.log.levels.INFO)
    end, { desc = 'Toggle format on save' })
  end,
}
