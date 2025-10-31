return {
  {
    -- Better diff viewing and merge conflict resolution
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff View' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it File [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it Project [H]istory' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = '[G]it Diff [C]lose' },
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
      { '<leader>gg', '<cmd>Neogit<cr>', desc = '[G]it Neo[g]it' },
      { '<leader>gC', '<cmd>Neogit commit<cr>', desc = '[G]it [C]ommit' },
      {
        '<leader>gb',
        function()
          vim.ui.input({ prompt = 'Go back to branch (or - for previous): ' }, function(branch)
            if branch and branch ~= '' then
              vim.cmd('Git checkout ' .. branch)
            end
          end)
        end,
        desc = '[G]it checkout [B]ranch',
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
