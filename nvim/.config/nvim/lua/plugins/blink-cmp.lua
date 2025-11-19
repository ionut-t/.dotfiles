-- Autocompletion using blink.cmp
return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },

    completion = {
      -- Documentation window
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      -- Menu appearance
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
        },
      },
      -- Auto brackets
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    -- Sources for completion
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Cmdline completion
    cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' or type == '?' then
          return { 'buffer' }
        end
        if type == ':' then
          return { 'cmdline' }
        end
        return {}
      end,
    },

    -- Signature help configuration
    signature = {
      enabled = true,
    },

    -- Fuzzy matching
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
    },
  },
  opts_extend = { 'sources.default' },
}
