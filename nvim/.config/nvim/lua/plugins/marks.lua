return {
  'chentoast/marks.nvim',
  config = function()
    require('marks').setup {
      default_mappings = false, -- Disable defaults, set custom
      builtin_marks = { '.', '<', '>', '^' },
      cyclic = true,
      force_write_shada = true,
      refresh_interval = 250,
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},
      bookmark_0 = {
        sign = '⚑',
        virt_text = '',
        annotate = false,
      },
    }

    -- Custom keymaps to avoid 'm' conflicts with which-key
    local map = vim.keymap.set
    -- Set marks using native vim: ma, mb, mc, etc. (no mapping needed)
    -- Navigate to marks (works via which-key picker or use backtick)
    map('n', ']b', '<Plug>(Marks-next)', { desc = 'Next mark' })
    map('n', '[b', '<Plug>(Marks-prev)', { desc = 'Previous mark' })
    map('n', '<leader>m,', '<Plug>(Marks-setnext)', { desc = 'Set next available mark' })
    map('n', '<leader>m;', '<Plug>(Marks-toggle)', { desc = 'Toggle mark' })
    map('n', '<leader>md', '<Plug>(Marks-deleteline)', { desc = 'Delete marks on line' })
    map('n', '<leader>mx', '<Plug>(Marks-deletebuf)', { desc = 'Delete all marks in buffer' })
    map('n', '<leader>m:', '<Plug>(Marks-preview)', { desc = 'Preview mark' })
  end,
}
