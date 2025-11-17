-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- Icon provider
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    priority = 1000,
    config = function()
      require('nvim-web-devicons').setup {
        default = true,
        strict = true,
        override_by_filename = {
          ['.gitignore'] = {
            icon = '',
            color = '#f1502f',
            name = 'Gitignore',
          },
        },
      }
    end,
  },
  -- {
  --   -- Icon provider for Neovim plugins
  --   'echasnovski/mini.icons',
  --   version = '*',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local icons = require('mini.icons')
  --     icons.setup()
  --     -- Mock nvim-web-devicons for plugins that depend on it (like Neo-tree)
  --     icons.mock_nvim_web_devicons()
  --   end,
  -- },
  {
    -- Tmux & split window navigation
    'christoomey/vim-tmux-navigator',
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Enhanced notifications
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss all notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      background_colour = '#000000',
      render = 'compact',
      stages = 'fade_in_slide_out',
    },
    config = function(_, opts)
      require('notify').setup(opts)
      vim.notify = require 'notify'
    end,
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    -- Enhanced search with match count (e.g., "3/18")
    'kevinhwang91/nvim-hlslens',
    event = 'BufReadPost',
    opts = {
      calm_down = true,
      nearest_only = true,
    },
    config = function(_, opts)
      require('hlslens').setup(opts)

      -- Enhance search navigation with match count
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
}
