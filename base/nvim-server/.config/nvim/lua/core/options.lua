-- Load base options directly (require would be circular since we shadow core.options)
dofile(vim.fn.expand '~/.dotfiles' .. '/base/nvim/.config/nvim/lua/core/options.lua')

-- Clipboard via OSC 52: yanks are forwarded to the local machine's clipboard
-- through the SSH connection → tmux → terminal (Ghostty supports OSC 52 natively)
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste '+',
    ['*'] = require('vim.ui.clipboard.osc52').paste '*',
  },
}
