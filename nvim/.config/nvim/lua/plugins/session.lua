return {
  'folke/persistence.nvim',
  lazy = false, -- Load immediately, not on event
  priority = 1000, -- Load early
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    need = 1, -- Minimum number of file buffers before saving
  },
  -- Auto-restore disabled - use <leader>qs to manually restore session
  config = function(_, opts)
    require('persistence').setup(opts)
  end,
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore session for current dir',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore last session (any dir)',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "Don't save session on exit",
    },
    {
      '<leader>qx',
      function()
        vim.ui.input({ prompt = 'Delete all sessions? (y/n): ' }, function(input)
          if input == 'y' or input == 'Y' then
            local session_dir = vim.fn.stdpath 'state' .. '/sessions/'
            vim.fn.system('rm -rf ' .. session_dir .. '*')
            vim.notify('All sessions deleted!', vim.log.levels.INFO)
          else
            vim.notify('Cancelled', vim.log.levels.INFO)
          end
        end)
      end,
      desc = 'Delete all sessions',
    },
    {
      '<leader>qq',
      '<cmd>qa<cr>',
      desc = 'Quit all',
    },
  },
}
