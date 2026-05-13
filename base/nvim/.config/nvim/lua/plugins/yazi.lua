return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>ee', '<cmd>Yazi<cr>', desc = 'Yazi (current file)' },
    { '<leader>er', '<cmd>Yazi cwd<cr>', desc = 'Yazi (cwd)' },
    {
      '<leader>es',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  opts = {
    open_for_directories = false,
  },
}
