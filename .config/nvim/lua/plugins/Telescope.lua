return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        telescope.setup {
            defaults = {
                file_ignore_patterns = {
                    "^node_modules/",
                    "^vendor/",
                    "^venv/",
                    "^.venv/",
                    "^env/",
                    "^.env/",
                    "^target/",
                    "/build/",
                    "^.git/",
                    "^dist/",
                    "^__pycache__/",
                    "^.next/",
                    "^out/",
                    "^coverage/",
                    "^logs?/",
                    "^tmp/",
                    "^.pytest_cache/",
                    "^.mypy_cache/",
                    "^.cargo/",
                    "^.gradle/",
                    "^.idea_modules/",
                    "^.history/",
                    "^.svn/",
                    "^.hg/",
                    "^.terraform/",
                    "^.serverless/",
                    "^.firebase/",
                    "^.nuxt/",
                    "^.expo/",
                    "^.angular/",
                    "^.svelte-kit/",
                    "^.yarn/",
                    "^.pnp/",
                    "^.worktrees/"
                },
               hidden = true,  -- Show hidden files (dotfiles)
               },
               pickers = {
                    find_files = {
                        hidden = true,  
                        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" } -- Use ripgrep to respect .gitignore
                    }
               }
            }
    end
}

