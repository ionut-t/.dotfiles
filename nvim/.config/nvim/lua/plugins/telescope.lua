return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master', -- Updated to master for Neovim 0.11+ compatibility
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Function to switch focus between picker and preview
    local focus_preview = function(prompt_bufnr)
      local action_state = require 'telescope.actions.state'
      local picker = action_state.get_current_picker(prompt_bufnr)
      local prompt_win = picker.prompt_win
      local previewer = picker.previewer

      if not previewer then
        return
      end

      local winid = previewer.state.winid
      local bufnr = previewer.state.bufnr

      -- Set up Tab to return to prompt from preview
      vim.keymap.set('n', '<Tab>', function()
        vim.cmd(string.format('noautocmd lua vim.api.nvim_set_current_win(%s)', prompt_win))
      end, { buffer = bufnr })

      -- Switch to preview window
      vim.cmd(string.format('noautocmd lua vim.api.nvim_set_current_win(%s)', winid))
    end

    require('telescope').setup {
      defaults = {
        -- Improved ripgrep arguments for better search
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden', -- Search hidden files by default
          '--glob=!.git/', -- Exclude .git directory
          '--glob=!node_modules/',
          '--glob=!.next/',
          '--glob=!dist/',
          '--glob=!build/',
          '--glob=!*.min.js',
          '--trim', -- Trim whitespace
        },

        -- Better path display for large projects
        path_display = { 'truncate' },

        -- Vertical layout: search on top, preview on bottom
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
            mirror = true,
          },
        },

        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-l>'] = require('telescope.actions').select_default,
            ['<Tab>'] = focus_preview,
            ['<CR>'] = function(prompt_bufnr)
              local actions = require 'telescope.actions'
              local action_state = require 'telescope.actions.state'
              local picker = action_state.get_current_picker(prompt_bufnr)
              local multi = picker:get_multi_selection()

              if #multi > 0 then
                -- Open all selected files
                actions.close(prompt_bufnr)
                for _, entry in ipairs(multi) do
                  vim.cmd(string.format('edit %s', entry.path or entry.filename))
                end
              else
                -- Normal behavior if no multi-selection
                actions.select_default(prompt_bufnr)
              end
            end,
          },
          n = {
            ['<Tab>'] = focus_preview,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true,
        },
        git_status = {
          git_icons = {
            added = 'A',
            changed = 'M',
            copied = 'C',
            deleted = 'D',
            renamed = 'R',
            unmerged = 'U',
            untracked = '?',
          },
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          additional_args = function(_)
            return { '--hidden' }
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'

    -- ═══════════════════════════════════════════════════════════════════
    -- FIND namespace (<Space>f) - Files, Buffers, UI elements
    -- ═══════════════════════════════════════════════════════════════════
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Telescope pickers' })

    -- Git files
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Git files' })
    vim.keymap.set('n', '<leader>fm', builtin.git_status, { desc = 'Modified files' })
    vim.keymap.set('n', '<leader>fc', function()
      -- Actions: <CR> checkout, <C-r> reset soft, <C-h> reset hard
      builtin.git_commits()
    end, { desc = 'Find commits (git)' })

    -- Contextual finds
    vim.keymap.set('n', '<leader>fs', function()
      local current_buffer = vim.api.nvim_buf_get_name(0)
      local parent_dir = vim.fn.fnamemodify(current_buffer, ':h')
      builtin.find_files {
        prompt_title = 'Sibling Files',
        cwd = parent_dir,
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
      }
    end, { desc = 'Sibling files' })

    -- vim.keymap.set('n', '<leader>fp', function()
    --     builtin.oldfiles {
    --         prompt_title = 'Recent Files (Project Only)',
    --         cwd_only = true,
    --     }
    -- end, { desc = 'Find recent in [P]roject' })

    -- ═══════════════════════════════════════════════════════════════════
    -- SEARCH namespace (<Space>s) - Content inside files
    -- ═══════════════════════════════════════════════════════════════════
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume' })

    -- Search in specific contexts
    vim.keymap.set('n', '<leader>sb', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'In buffer' })

    vim.keymap.set('n', '<leader>so', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'In open files' })

    -- Enhanced search with telescope-live-grep-args
    vim.keymap.set('n', '<leader>sg', function()
      require('telescope').extensions.live_grep_args.live_grep_args()
    end, { desc = 'Grep with args' })

    -- Search for TODO/FIXME/NOTE comments
    vim.keymap.set('n', '<leader>st', function()
      builtin.live_grep {
        prompt_title = 'Search TODOs',
        default_text = 'TODO|FIXME|NOTE|HACK|XXX',
      }
    end, { desc = 'TODOs' })

    -- Visual mode search: search for selected text
    vim.keymap.set('v', '<leader>s', function()
      -- Get visual selection
      vim.cmd 'noau normal! "vy"'
      local text = vim.fn.getreg 'v'
      vim.fn.setreg('v', {})

      -- Escape special characters
      text = string.gsub(text, '([^%w])', '%%%1')

      builtin.grep_string { search = text }
    end, { desc = 'Search selection' })

    -- Search without respecting .gitignore
    vim.keymap.set('n', '<leader>sN', function()
      builtin.live_grep {
        prompt_title = 'Search (no ignore)',
        additional_args = function()
          return { '--no-ignore' }
        end,
      }
    end, { desc = 'Everywhere (no ignore)' })
  end,
}
