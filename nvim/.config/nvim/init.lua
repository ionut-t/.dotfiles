require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.whichkey',
  require 'plugins.misc',
  require 'plugins.snacks', -- Snacks.nvim utilities
  require 'plugins.dressing',
  require 'plugins.inc-rename', -- LSP rename with live preview
  require 'plugins.harpoon', -- Quick file navigation
  require 'plugins.marks', -- Mark lines within buffers
  require 'plugins.flash', -- Fast navigation with labeled jumps
  require 'plugins.multi-cursor',
  -- require 'plugins.neotree',
  require 'plugins.oil',
  require 'plugins.mini', -- Mini.nvim modules
  require 'plugins.theme',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.treesitter-context',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion', -- Old nvim-cmp (disabled)
  require 'plugins.blink-cmp', -- New blink.cmp completion
  require 'plugins.formatter',
  require 'plugins.linter',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.noice',
  require 'plugins.angular',
  require 'plugins.typescript',
  require 'plugins.go',
  require 'plugins.python',
  require 'plugins.copilot',
  require 'plugins.zig',
  require 'plugins.rust',
  require 'plugins.trouble',
  require 'plugins.session',
  require 'plugins.refactoring',
  require 'plugins.git-enhanced',
  -- require 'plugins.dap-multi',
  -- require 'plugins.testing',
  require 'plugins.terminal',
  require 'plugins.search',
  require 'plugins.tiny-diagnostic',
  require 'plugins.snipe',
  require 'plugins.autotag',
  require 'plugins.neotest',
}

vim.cmd.colorscheme 'catppuccin'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
