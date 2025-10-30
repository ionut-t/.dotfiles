return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    need = 1, -- Minimum number of file buffers before saving
  },
  config = function(_, opts)
    require('persistence').setup(opts)

    -- Auto-restore session when opening Neovim without arguments
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('persistence_autoload', { clear = true }),
      callback = function()
        -- Only load session if nvim was started with no args
        if vim.fn.argc() == 0 then
          require('persistence').load()
        end
      end,
      nested = true,
    })
  end,
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = '[Q]uit and restore [S]ession',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[Q]uit and restore [L]ast Session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "[Q]uit [D]on't save current session",
    },
  },
}
