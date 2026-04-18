return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = 'ToggleTerm',
  opts = {
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = 'curved',
      winblend = 0,
      width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.5)
      end,
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Add easy close keymaps for terminal buffers
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        -- Esc exits insert mode, then use :close or <leader>tt to close
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = 0, nowait = true })
      end,
    })
  end,
}
