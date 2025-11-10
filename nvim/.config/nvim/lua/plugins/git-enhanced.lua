return {
  {
    -- Better diff viewing and merge conflict resolution
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git diff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git project history' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Git diff close' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = 'diff2_horizontal' },
        merge_tool = { layout = 'diff3_horizontal' },
      },
    },
  },
  {
    -- Magit-like git interface
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Git neogit' },
      { '<leader>gC', '<cmd>Neogit commit<cr>', desc = 'Git commit' },
      {
        '<leader>gc',
        function()
          vim.ui.input({ prompt = 'Go back to branch (or - for previous): ' }, function(branch)
            if branch and branch ~= '' then
              vim.cmd('Git checkout ' .. branch)
            end
          end)
        end,
        desc = 'Git checkout branch',
      },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
      graph_style = 'unicode',
    },
  },
}
