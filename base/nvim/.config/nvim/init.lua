require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.autocmds'

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

local function lens_open(args)
  local cmd = 'lens'
  for _, a in ipairs(args or {}) do
    cmd = cmd .. ' ' .. vim.fn.shellescape(a)
  end

  if not vim.env.TMUX then
    vim.cmd 'vsplit | enew'
    vim.fn.jobstart(cmd, { term = true })
    vim.cmd 'startinsert'
    return
  end

  -- Reuse an existing lens pane in this window, if any.
  local panes = vim.fn.systemlist "tmux list-panes -F '#{pane_id} #{pane_current_command}'"
  for _, line in ipairs(panes) do
    local pane = line:match '^(%%%d+) lens$'
    if pane then
      vim.fn.system { 'tmux', 'respawn-pane', '-k', '-t', pane, cmd }
      return
    end
  end
  -- No lens pane yet — open one on the right, keeping focus in nvim.
  vim.fn.system { 'tmux', 'split-window', '-dh', '-l', '40%', cmd }
end

-- Name of the it/test/describe block enclosing the cursor (via treesitter).
local function nearest_test()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok then
    return nil
  end
  while node do
    if node:type() == 'call_expression' then
      local fn = node:field('function')[1]
      local callee = fn and vim.treesitter.get_node_text(fn, 0) or ''
      local base = callee:match '^([%a_][%w_]*)' -- it.only -> it
      if base == 'it' or base == 'test' or base == 'describe' then
        local args = node:field('arguments')[1]
        local first = args and args:named_child(0)
        if first then
          local text = vim.treesitter.get_node_text(first, 0)
          return (text:gsub('^["\'`]', ''):gsub('["\'`]$', ''))
        end
      end
    end
    node = node:parent()
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(ev)
    -- Build args fresh on every invocation: a shared table mutated with
    -- list_extend accumulates duplicate --test flags across runs.
    local function base_args()
      return { '--file', vim.api.nvim_buf_get_name(0), '--watch', '--hide-failed', '--layout', 'vertical' }
    end
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map('<leader>lf', function()
      lens_open(base_args())
    end, 'lens: run current file')
    map('<leader>ll', function()
      local args = base_args()
      local name = nearest_test()
      if name then
        vim.list_extend(args, { '--test', name })
      end
      lens_open(args)
    end, 'lens: run nearest test/suite')
  end,
})

-- Set up plugins
require('lazy').setup {
  require 'plugins.whichkey',
  require 'plugins.misc',
  require 'plugins.snacks', -- Snacks.nvim utilities
  require 'plugins.inc-rename', -- LSP rename with live preview
  require 'plugins.harpoon', -- Quick file navigation
  require 'plugins.marks', -- Mark lines within buffers
  require 'plugins.flash', -- Fast navigation with labeled jumps
  require 'plugins.multi-cursor',
  require 'plugins.oil',
  require 'plugins.yazi',
  require 'plugins.mini', -- Mini.nvim modules
  require 'plugins.theme',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.treesitter-context',
  require 'plugins.ufo', -- Folding with preview
  require 'plugins.telescope',
  require 'plugins.telescope-live-grep-args', -- Advanced ripgrep integration
  require 'plugins.lsp',
  require 'plugins.blink-cmp',
  require 'plugins.formatter',
  require 'plugins.linter',
  require 'plugins.gitsigns',
  require 'plugins.git-blame',
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
  require 'plugins.dap-multi',
  require 'plugins.terminal',
  require 'plugins.tiny-diagnostic',
  require 'plugins.snipe',
  require 'plugins.autotag',
  require 'plugins.neotest',
}

vim.cmd.colorscheme 'catppuccin'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
