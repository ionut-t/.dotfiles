return {
  'folke/persistence.nvim',
  lazy = false, -- Load immediately, not on event
  priority = 1000, -- Load early
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    need = 1, -- Minimum number of file buffers before saving
  },
  init = function()
    -- Auto-restore session BEFORE plugins load
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('persistence_autoload', { clear = true }),
      callback = function()
        -- Only load session if nvim was started with no args
        if vim.fn.argc() == 0 then
          local session_file = vim.fn.stdpath 'state' .. '/sessions/' .. vim.fn.getcwd():gsub('/', '%%') .. '.vim'

          -- Debug output
          print('Checking for session: ' .. session_file)
          print('File exists: ' .. vim.fn.filereadable(session_file))

          if vim.fn.filereadable(session_file) == 1 then
            print('Loading session...')
            vim.schedule(function()
              require('persistence').load()
              print('Session loaded!')
            end)
          else
            print('No session file found')
          end
        else
          print('argc() = ' .. vim.fn.argc() .. ', skipping auto-restore')
        end
      end,
      nested = true,
    })
  end,
  config = function(_, opts)
    require('persistence').setup(opts)
  end,
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore [S]ession for current dir',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore [L]ast session (any dir)',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "[D]on't save session on exit",
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
  },
}
