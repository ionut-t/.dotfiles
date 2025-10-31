return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal', mode = { 'n', 't' } },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal [F]loat' },
    { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]erminal [H]orizontal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = '[T]erminal [V]ertical' },
  },
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = 'curved',
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
    winbar = {
      enabled = false,
    },
  },
}
