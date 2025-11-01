-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim.
-- Scheduled after `UiEnter` to improve startup time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode with jj
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })

-- Enter visual mode from insert mode with vv, visual line mode with VV
vim.keymap.set('i', 'vv', '<Esc>v', { desc = 'Enter visual mode from insert' })
vim.keymap.set('i', 'VV', '<Esc>V', { desc = 'Enter visual line mode from insert' })

-- Diagnostic keymaps (consolidated under <leader>x for diagnostics/quickfix - LazyVim standard)
vim.keymap.set('n', '<leader>xx', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list' })
vim.keymap.set('n', '<leader>xf', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
vim.keymap.set('n', '<leader>xn', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>xp', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })

-- Keep [d / ]d for muscle memory
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Window left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Window right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Window up' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Open terminal in current file's directory
vim.keymap.set('n', '<leader>Tt', function()
  -- Get the directory of the current file, handling oil:// paths
  local path = vim.fn.expand '%:p'
  local file_dir

  -- Check if this is an oil path and convert it
  if path:match '^oil://' then
    -- Convert oil:// path to real path (remove the oil:// prefix)
    file_dir = path:gsub('^oil://', '')
  else
    -- Regular file, get its directory
    file_dir = vim.fn.expand '%:p:h'
  end

  -- Open a split for the terminal
  vim.cmd 'split'
  vim.cmd 'resize 15'
  -- Open terminal with the cd command
  vim.cmd('terminal cd "' .. file_dir .. '" && $SHELL')
  -- Automatically enter insert mode in the terminal
  vim.cmd 'startinsert'
end, { desc = 'Terminal in file directory' })

-- Open terminal in vertical split in current file's directory
vim.keymap.set('n', '<leader>Tv', function()
  -- Get the directory of the current file, handling oil:// paths
  local path = vim.fn.expand '%:p'
  local file_dir

  -- Check if this is an oil path and convert it
  if path:match '^oil://' then
    -- Convert oil:// path to real path (remove the oil:// prefix)
    file_dir = path:gsub('^oil://', '')
  else
    -- Regular file, get its directory
    file_dir = vim.fn.expand '%:p:h'
  end

  vim.cmd 'vsplit'
  -- Open terminal with the cd command
  vim.cmd('terminal cd "' .. file_dir .. '" && $SHELL')
  vim.cmd 'startinsert'
end, { desc = 'Terminal vertical in file directory' })

-- Reload a specific plugin module (useful for plugin config changes)
vim.keymap.set('n', '<leader>rp', function()
  vim.ui.input({ prompt = 'Plugin to reload (e.g., telescope): ' }, function(input)
    if input then
      -- Clear the plugin module from cache
      package.loaded['plugins.' .. input] = nil

      -- Try to reload with Lazy
      local ok, err = pcall(vim.cmd, 'Lazy reload ' .. input .. '.nvim')
      if ok then
        vim.notify('Reloaded ' .. input .. '.nvim', vim.log.levels.INFO)
      else
        vim.notify('Failed to reload ' .. input .. ': ' .. err, vim.log.levels.ERROR)
      end
    end
  end)
end, { desc = 'Reload plugin' })

-- Reload core configuration files (options, keymaps, snippets)
vim.keymap.set('n', '<leader>rl', function()
  -- Clear Lua module cache for core modules
  for name, _ in pairs(package.loaded) do
    if name:match '^core' then
      package.loaded[name] = nil
    end
  end

  -- Reload core modules
  require 'core.options'
  require 'core.keymaps'
  require 'core.snippets'

  vim.notify('Core configuration files reloaded!', vim.log.levels.INFO)
end, { desc = 'Reload core config files' })

-- Quick exit and save (with session persistence)
vim.keymap.set('n', '<leader>rr', function()
  -- Save current session if persistence is loaded
  local ok = pcall(require, 'persistence')
  if ok then
    require('persistence').save()
  end

  -- Exit (session will restore on next open)
  vim.cmd 'wqa'
end, { desc = 'Restart/exit neovim (saves session)' })

-- Buffer management
-- Close all buffers
vim.keymap.set('n', '<leader>bD', function()
  vim.cmd 'bufdo Bdelete'
end, { desc = 'Buffer delete all' })

-- Close all buffers except current
vim.keymap.set('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buftype') == '' then
      vim.cmd('Bdelete ' .. buf)
    end
  end
end, { desc = 'Buffer delete others' })

-- Move buffer left/right
vim.keymap.set('n', '<leader>b[', ':BufferLineMovePrev<CR>', { desc = 'Buffer move left', silent = true })
vim.keymap.set('n', '<leader>b]', ':BufferLineMoveNext<CR>', { desc = 'Buffer move right', silent = true })
