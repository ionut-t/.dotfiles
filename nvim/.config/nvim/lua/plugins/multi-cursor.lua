return {
  'mg979/vim-visual-multi',
  event = 'VeryLazy',
  init = function()
    vim.g.VM_maps = {
      ['Find Under'] = '<C-d>', -- Start selecting next occurrence (like Cmd+D)
      ['Find Subword Under'] = '<C-d>', -- Same as above
      ['Skip Region'] = '<C-x>', -- Skip current and select next
      ['Remove Region'] = '<C-p>', -- Remove current selection
      ['Goto Next'] = '', -- Disable to avoid conflicts
      ['Goto Prev'] = '', -- Disable to avoid conflicts
    }

    -- Disable default mappings that might conflict
    vim.g.VM_default_mappings = 0

    -- Set custom mappings
    vim.g.VM_custom_motions = {
      ['j'] = 'j',
      ['k'] = 'k',
      ['h'] = 'h',
      ['l'] = 'l',
    }

    -- Theme integration
    vim.g.VM_theme = 'purplegray'

    -- Hide notifications
    vim.g.VM_silent_exit = 1
  end,
  keys = {
    { '<C-d>', mode = { 'n', 'v' }, desc = 'Multi-cursor: Select next occurrence' },
    { '<C-x>', mode = { 'n', 'v' }, desc = 'Multi-cursor: Skip current' },
  },
}
