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

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

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
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
vim.keymap.set('n', '<leader>tt', function()
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
end, { desc = 'Open terminal in current file directory' })

-- Open terminal in vertical split in current file's directory
vim.keymap.set('n', '<leader>tv', function()
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
end, { desc = 'Open terminal in vertical split in current file directory' })

-- Reload configuration without restarting Neovim
vim.keymap.set('n', '<leader>rc', function()
  -- Source the init.lua file
  vim.cmd 'source $MYVIMRC'
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end, { desc = 'Reload nvim configuration' })

-- Reload configuration files only (faster, but doesn't reload plugins)
vim.keymap.set('n', '<leader>rl', function()
  -- Reload important config files
  for _, file in ipairs {
    vim.fn.stdpath 'config' .. '/lua/core/options.lua',
    vim.fn.stdpath 'config' .. '/lua/core/keymaps.lua',
    vim.fn.stdpath 'config' .. '/lua/core/snippets.lua',
  } do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd('source ' .. file)
    end
  end
  vim.notify('Configuration files reloaded!', vim.log.levels.INFO)
end, { desc = 'Reload lua configuration files' })
