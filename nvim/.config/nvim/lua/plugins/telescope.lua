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
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = require('telescope.actions').move_selection_previous,
                        ['<C-j>'] = require('telescope.actions').move_selection_next,
                        ['<C-l>'] = require('telescope.actions').select_default,
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
            },
            live_grep = {
                file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                additional_args = function(_)
                    return { '--hidden' }
                end,
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
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecent files' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = '[F]ind [T]elescope pickers' })

        -- Git files
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it files' })
        vim.keymap.set('n', '<leader>fm', builtin.git_status, { desc = '[F]ind [M]odified files (git)' })
        vim.keymap.set('n', '<leader>fc', function()
            -- Actions: <CR> checkout, <C-r> reset soft, <C-h> reset hard
            builtin.git_commits()
        end, { desc = '[F]ind [C]ommits (git)' })

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
        end, { desc = '[F]ind [S]ibling files' })

        vim.keymap.set('n', '<leader>fp', function()
            builtin.oldfiles {
                prompt_title = 'Recent Files (Project Only)',
                cwd_only = true,
            }
        end, { desc = '[F]ind recent in [P]roject' })

        -- ═══════════════════════════════════════════════════════════════════
        -- SEARCH namespace (<Space>s) - Content inside files
        -- ═══════════════════════════════════════════════════════════════════
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

        -- Search in specific contexts
        vim.keymap.set('n', '<leader>sb', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[S]earch in [B]uffer' })

        vim.keymap.set('n', '<leader>so', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch in [O]pen files' })

        -- Keep legacy mappings for compatibility (can remove after getting used to new ones)
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Search in current buffer' })

        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find buffers (quick access)' })
    end,
}
