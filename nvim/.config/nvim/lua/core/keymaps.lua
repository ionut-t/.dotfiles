-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable Space's default behavior (moving cursor right) to prevent conflicts
-- This ensures Space ONLY works as leader key, even before plugins load
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

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

-- Remap U to redo (default is <C-r>)
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- Paste without yanking replaced text (visual/select mode)
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste without yank' })

-- Delete without yanking (use black hole register)
vim.keymap.set({ 'n', 'x' }, 'd', '"_d', { desc = 'Delete without yank' })
vim.keymap.set({ 'n', 'x' }, 'D', '"_D', { desc = 'Delete to end without yank' })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete char without yank' })
vim.keymap.set({ 'n', 'x' }, 'X', '"_X', { desc = 'Delete char back without yank' })

-- Copy file paths to clipboard
vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  vim.notify('Copied relative path: ' .. path, vim.log.levels.INFO)
end, { desc = 'Relative path' })

vim.keymap.set('n', '<leader>yP', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path, vim.log.levels.INFO)
end, { desc = 'Absolute path' })

-- Copy file name to clipboard
vim.keymap.set('n', '<leader>yn', function()
  local name = vim.fn.expand '%:t'
  vim.fn.setreg('+', name)
  vim.notify('Copied file name: ' .. name, vim.log.levels.INFO)
end, { desc = 'File name' })

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
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!!"<CR>')

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
    vim.hl.on_yank()
  end,
})

-- Quick command mode entry from insert mode
vim.keymap.set('i', 'kk', '<Esc>:', { desc = 'Exit to command mode' })

-- Delete without copying to clipboard (dd = delete line, d = delete motion)
vim.keymap.set('n', 'dd', '"_dd', { desc = 'Delete line' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete selection' })

-- For other delete modes in normal mode, yank content
vim.keymap.set('n', 'd', 'd', { desc = 'Delete' })

-- Delete and copy (dx = cut line, x = cut motion in visual)
vim.keymap.set('n', 'dx', 'dd', { desc = 'Cut line' })
vim.keymap.set('v', 'x', 'd', { desc = 'Cut selection' })

-- Open terminal in current file's directory
-- Track the last directory to detect when we need a new terminal
_G.last_term_dir = nil
_G.term_count = 1

vim.keymap.set('n', '<leader>tt', function()
  local current_dir = vim.fn.expand '%:p:h'

  -- If we're in a different directory, increment terminal count to get a new one
  if _G.last_term_dir and _G.last_term_dir ~= current_dir then
    _G.term_count = _G.term_count + 1
  end
  _G.last_term_dir = current_dir

  vim.cmd(_G.term_count .. 'ToggleTerm dir=' .. vim.fn.fnameescape(current_dir))
end, { desc = 'Toggle terminal in current dir' })

-- Kill all terminals and reset counter
vim.keymap.set('n', '<leader>tk', function()
  local terms = require('toggleterm.terminal').get_all()
  for _, term in pairs(terms) do
    term:shutdown()
  end
  _G.last_term_dir = nil
  _G.term_count = 1
  vim.notify('All terminals closed', vim.log.levels.INFO)
end, { desc = 'Kill all terminals' })

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
-- Create new buffers with optional filename in current buffer's directory
vim.keymap.set('n', '<leader>bn', function()
  local current_dir_abs = vim.fn.expand '%:p:h'
  local current_dir_rel = vim.fn.expand '%:.:h'
  vim.ui.input({ prompt = 'New file in ' .. current_dir_rel .. '\nFilename: ' }, function(input)
    if input then
      vim.cmd 'enew'
      if input ~= '' then
        local full_path = current_dir_abs .. '/' .. input
        -- Create parent directories if they don't exist
        local parent_dir = vim.fn.fnamemodify(full_path, ':h')
        vim.fn.mkdir(parent_dir, 'p')
        vim.cmd('file ' .. vim.fn.fnameescape(full_path))
      end
    end
  end)
end, { desc = 'New' })

vim.keymap.set('n', '<leader>bN', function()
  local current_dir_abs = vim.fn.expand '%:p:h'
  local current_dir_rel = vim.fn.expand '%:.:h'
  vim.ui.input({ prompt = 'New file in ' .. current_dir_rel .. '\nFilename: ' }, function(input)
    if input then
      vim.cmd 'new'
      if input ~= '' then
        local full_path = current_dir_abs .. '/' .. input
        -- Create parent directories if they don't exist
        local parent_dir = vim.fn.fnamemodify(full_path, ':h')
        vim.fn.mkdir(parent_dir, 'p')
        vim.cmd('file ' .. vim.fn.fnameescape(full_path))
      end
    end
  end)
end, { desc = 'New (split)' })

vim.keymap.set('n', '<leader>bv', function()
  local current_dir_abs = vim.fn.expand '%:p:h'
  local current_dir_rel = vim.fn.expand '%:.:h'
  vim.ui.input({ prompt = 'New file in ' .. current_dir_rel .. '\nFilename: ' }, function(input)
    if input then
      vim.cmd 'vnew'
      if input ~= '' then
        local full_path = current_dir_abs .. '/' .. input
        -- Create parent directories if they don't exist
        local parent_dir = vim.fn.fnamemodify(full_path, ':h')
        vim.fn.mkdir(parent_dir, 'p')
        vim.cmd('file ' .. vim.fn.fnameescape(full_path))
      end
    end
  end)
end, { desc = 'New (vsplit)' })

-- Replace the word cursor is on globally (normal mode) - empty replacement
vim.keymap.set('n', '<leader>rc', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = 'Replace word' })

-- Replace the word cursor is on globally (normal mode) - with replacement prefilled
vim.keymap.set('n', '<leader>rC', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word (prefilled)' })

-- Replace visual selection globally (visual mode) - empty replacement
vim.keymap.set('v', '<leader>rc', function()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})
  text = vim.fn.escape(text, [[/\]])
  vim.fn.feedkeys(':%s/' .. text .. '//gI' .. string.rep(vim.api.nvim_replace_termcodes('<Left>', true, false, true), 3), 'n')
end, { desc = 'Replace selection (empty)' })

-- Replace visual selection globally (visual mode) - with replacement prefilled
vim.keymap.set('v', '<leader>rC', function()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})
  text = vim.fn.escape(text, [[/\]])
  vim.fn.feedkeys(':%s/' .. text .. '/' .. text .. '/gI' .. string.rep(vim.api.nvim_replace_termcodes('<Left>', true, false, true), 3), 'n')
end, { desc = 'Replace selection (prefilled)' })

vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'moves lines down in visual selection' })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'moves lines up in visual selection' })

-- Move line down/up in normal mode
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { desc = 'Move line up' })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

local opts = { noremap = true, silent = true }
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Quick buffer switching
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>', { desc = 'Switch to previous buffer' })

-- Macro recording
vim.keymap.set('n', 'q', function()
  if vim.fn.reg_recording() ~= '' then
    -- Currently recording, allow q to stop
    return 'q'
  else
    return ''
  end
end, { expr = true, desc = 'Stop macro recording (or show hint)' })
vim.keymap.set('n', 'Q', 'q', { desc = 'Start macro recording', noremap = false })
