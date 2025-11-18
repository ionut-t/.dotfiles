return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    -- Labels used for labeling targets
    labels = 'asdfghjklqwertyuiopzxcvbnm',

    -- Search settings
    search = {
      -- Search mode: exact, search, fuzzy
      mode = 'exact',
      -- Incremental search
      incremental = false,
      -- Exclude certain filetypes
      exclude = {
        'notify',
        'cmp_menu',
        'noice',
        'flash_prompt',
        function(win)
          -- Exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },

    -- Jump settings
    jump = {
      -- Jump on partial match (before all labels are typed)
      jumplist = true,
      -- Jump position: start, end
      pos = 'start',
      -- Add to jump list
      history = false,
      -- Jump to first match automatically if only one match
      autojump = false,
    },

    -- Label settings
    label = {
      -- Show labels above the matches
      uppercase = true,
      -- Exclude certain filetypes from labels
      exclude = '',
      -- Label before or after the match
      before = true,
      after = true,
      -- Style: 'overlay', 'inline', 'eol'
      style = 'overlay',
      -- Reuse labels that were already used in the current search
      reuse = 'lowercase',
      -- Format label
      format = function(opts)
        return { { opts.match.label, opts.hl_group } }
      end,
    },

    -- Highlight settings
    highlight = {
      -- Show backdrop
      backdrop = true,
      -- Backdrop transparency (0-100)
      backdrop_transparency = 70,
      -- Highlight matches
      matches = true,
      -- Highlight priority
      priority = 5000,
    },

    -- Mode settings
    modes = {
      -- Normal mode search (s)
      search = {
        enabled = true,
        -- Search with 2 characters
        incremental = false,
      },
      -- Character mode (f, F, t, T)
      char = {
        enabled = true,
        -- Show labels for char mode
        keys = { 'f', 'F', 't', 'T' },
        -- Character to use for search
        search = { wrap = false },
        -- Highlight on key press
        highlight = { backdrop = true },
        -- Jump settings for char mode
        jump = { register = false },
      },
      -- Treesitter search (S)
      treesitter = {
        enabled = true,
        labels = 'abcdefghijklmnopqrstuvwxyz',
        jump = { pos = 'range' },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },
    },

    -- Prompt settings
    prompt = {
      enabled = true,
      prefix = { { '⚡', 'FlashPromptIcon' } },
      win_config = {
        relative = 'editor',
        width = 1,
        height = 1,
        row = -1,
        col = 0,
        zindex = 1000,
      },
    },
  },

  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash jump',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Flash remote',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash treesitter search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash search',
    },
  },
}
