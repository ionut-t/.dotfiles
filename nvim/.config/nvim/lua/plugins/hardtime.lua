return {
  'm4xshen/hardtime.nvim',
  command = 'Hardtime',
  event = 'BufEnter',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disabled_keys = {
      ['<Up>'] = false,
      ['<Down>'] = false,
      ['<Left>'] = false,
      ['<Right>'] = false,
    },
  },
}
