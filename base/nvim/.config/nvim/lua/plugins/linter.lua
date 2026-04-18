return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  keys = {
    {
      '<leader>cl',
      function()
        require('lint').try_lint()
      end,
      desc = 'Trigger linting for current buffer',
    },
  },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      -- python linting handled by ruff LSP (no redundant nvim-lint needed)
      make = { 'checkmake' },
      go = { 'golangcilint' },
      sql = { 'sqlfluff' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
