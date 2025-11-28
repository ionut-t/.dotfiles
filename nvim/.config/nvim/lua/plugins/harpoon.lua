return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    -- Add current file to harpoon
    vim.keymap.set('n', '<leader>ma', function()
      harpoon:list():add()
      vim.notify('Added to Harpoon', vim.log.levels.INFO)
    end, { desc = 'Add file' })

    -- Toggle harpoon menu
    vim.keymap.set('n', '<leader>mm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Menu' })

    -- Jump to specific files (1-4)
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon file 1' })

    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon file 2' })

    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon file 3' })

    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon file 4' })

    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { desc = 'Harpoon file 5' })

    -- Navigate to next/previous harpoon file
    vim.keymap.set('n', '[h', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon prev' })

    vim.keymap.set('n', ']h', function()
      harpoon:list():next()
    end, { desc = 'Harpoon next' })
  end,
}
