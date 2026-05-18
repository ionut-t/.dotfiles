-- Add base nvim config to rtp so shared plugin files are found without duplication
vim.opt.rtp:append(vim.fn.expand '~/.dotfiles' .. '/base/nvim/.config/nvim')

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugins.whichkey',
  require 'plugins.misc',
  require 'plugins.snacks',
  require 'plugins.inc-rename',
  require 'plugins.harpoon',
  require 'plugins.marks',
  require 'plugins.flash',
  require 'plugins.multi-cursor',
  require 'plugins.oil',
  require 'plugins.yazi',
  require 'plugins.mini',
  require 'plugins.theme',
  require 'plugins.lualine',
  require 'plugins.treesitter', -- server override: no angular/zig parsers
  require 'plugins.treesitter-context',
  require 'plugins.ufo',
  require 'plugins.telescope',
  require 'plugins.telescope-live-grep-args',
  require 'plugins.lsp', -- server override: no angular/html/css/zig/docker LSPs
  require 'plugins.blink-cmp',
  require 'plugins.formatter', -- server override: no html/angular/css formatters, portable sql path
  require 'plugins.linter',
  require 'plugins.gitsigns',
  require 'plugins.git-blame',
  require 'plugins.indent-blankline',
  require 'plugins.noice',
  require 'plugins.typescript',
  require 'plugins.go', -- server override: dap disabled
  require 'plugins.python',
  require 'plugins.rust', -- server override: no dap debuggables keymap
  require 'plugins.trouble',
  require 'plugins.session',
  require 'plugins.refactoring',
  require 'plugins.git-enhanced',
  require 'plugins.terminal',
  require 'plugins.tiny-diagnostic',
  require 'plugins.snipe',
}

vim.cmd.colorscheme 'catppuccin'
-- vim: ts=2 sts=2 sw=2 et
