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
        require('telescope').setup {
            defaults = {
                -- Better path display for large projects
                path_display = { "truncate" },

                -- Vertical layout: search on top, preview on bottom
                layout_strategy = "vertical",
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
                        ['<CR>'] = function(prompt_bufnr)
                            local actions = require('telescope.actions')
                            local action_state = require('telescope.actions.state')
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
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
        vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Find telescope pickers' })

        -- Git files
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find git files' })
        vim.keymap.set('n', '<leader>fm', builtin.git_status, { desc = 'Find modified files (git)' })
        vim.keymap.set('n', '<leader>fc', function()
            -- Actions: <CR> checkout, <C-r> reset soft, <C-h> reset hard
            builtin.git_commits()
        end, { desc = 'Find commits (git)' })

        -- Contextual finds
        -- vim.keymap.set('n', '<leader>fs', function()
        --     local current_buffer = vim.api.nvim_buf_get_name(0)
        --     local parent_dir = vim.fn.fnamemodify(current_buffer, ':h')
        --     builtin.find_files {
        --         prompt_title = 'Sibling Files',
        --         cwd = parent_dir,
        --         hidden = true,
        --         no_ignore = true,
        --         file_ignore_patterns = { 'node_modules', '.git', '.venv' },
        --     }
        -- end, { desc = 'Find sibling files' })
        --
        -- vim.keymap.set('n', '<leader>fp', function()
        --     builtin.oldfiles {
        --         prompt_title = 'Recent Files (Project Only)',
        --         cwd_only = true,
        --     }
        -- end, { desc = 'Find recent in [P]roject' })
        --
        -- ═══════════════════════════════════════════════════════════════════
        -- SEARCH namespace (<Space>s) - Content inside files
        -- ═══════════════════════════════════════════════════════════════════
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search resume' })

        -- Search in specific contexts
        vim.keymap.set('n', '<leader>sb', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = 'Search in buffer' })

        vim.keymap.set('n', '<leader>so', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = 'Search in open files' })

        -- Keep legacy mappings for compatibility (can remove after getting used to new ones)
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = 'Search in current buffer' })
    end,
}
