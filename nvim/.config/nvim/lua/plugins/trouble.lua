return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- Use Neovim's default diagnostic signs
    use_diagnostic_signs = true,
    -- Action keys for navigating and interacting with diagnostics
    action_keys = {
      close = 'q', -- close the list
      cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
      refresh = 'r', -- manually refresh
      jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
      open_split = { '<c-x>' }, -- open buffer in new split
      open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
      open_tab = { '<c-t>' }, -- open buffer in new tab
      jump_close = { 'o' }, -- jump to the diagnostic and close the list
      toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = 'P', -- toggle auto_preview
      hover = 'K', -- opens a small popup with the full multiline message
      preview = 'p', -- preview the diagnostic location
      close_folds = { 'zM', 'zm' }, -- close all folds
      open_folds = { 'zR', 'zr' }, -- open all folds
      toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
      previous = 'k', -- previous item
      next = 'j', -- next item
    },
    -- Automatically open trouble when there are diagnostics
    auto_open = false,
    -- Automatically close trouble when there are no diagnostics
    auto_close = false,
    -- Automatically preview the diagnostic location
    auto_preview = true,
    -- Auto fold closed groups with 0 results
    auto_fold = false,
    -- Show diagnostics signs in the sign column
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '',
    },
    -- Include all severity levels
    severity = nil, -- nil means all severity levels
    -- Show diagnostic source
    include_declaration = { 'lsp', 'coc', 'ale' },
  },
  config = function(_, opts)
    require('trouble').setup(opts)

    -- Keymaps for trouble (consolidated under <leader>q for diagnostics)
    vim.keymap.set('n', '<leader>qt', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle [T]rouble diagnostics' })
    vim.keymap.set(
      'n',
      '<leader>qb',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      { desc = '[B]uffer diagnostics (Trouble)' }
    )
    vim.keymap.set('n', '<leader>qs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = '[S]ymbols (Trouble)' })
    vim.keymap.set(
      'n',
      '<leader>ql',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      { desc = '[L]SP definitions/references (Trouble)' }
    )
    vim.keymap.set('n', '<leader>qL', '<cmd>Trouble loclist toggle<cr>', { desc = '[L]ocation list (Trouble)' })
    vim.keymap.set('n', '<leader>qQ', '<cmd>Trouble qflist toggle<cr>', { desc = '[Q]uickfix list (Trouble)' })

    -- Keymaps for focusing trouble panel and buffer
    vim.keymap.set('n', '<leader>qF', '<cmd>Trouble diagnostics focus<cr>', { desc = '[F]ocus Trouble panel' })
    vim.keymap.set('n', '<leader>qr', '<cmd>wincmd p<cr>', { desc = '[R]eturn to buffer from Trouble' })
  end,
}
