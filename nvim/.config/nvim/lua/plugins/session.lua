return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  },
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
