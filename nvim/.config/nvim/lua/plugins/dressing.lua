return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      enabled = true,
      default_prompt = '➤ ',
      prompt_align = 'left',
      insert_only = false,
      start_in_insert = true,
      border = 'rounded',
      relative = 'cursor',
      prefer_width = 40,
      width = nil,
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      win_options = {
        winblend = 0,
        wrap = false,
      },
      -- Custom mapping to override inc-rename prompts
      get_config = function(opts)
        if opts.prompt and opts.prompt:find 'New Name' then
          return {
            prompt = 'Rename: ',
            default = opts.default,
          }
        end
      end,
    },
    select = {
      enabled = true,
      backend = { 'telescope', 'builtin', 'nui' },
      trim_prompt = true,
      telescope = nil,
      builtin = {
        border = 'rounded',
        relative = 'editor',
        win_options = {
          winblend = 0,
        },
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },
      },
    },
  },
}
