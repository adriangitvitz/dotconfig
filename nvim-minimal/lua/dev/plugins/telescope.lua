return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local builtin = require("telescope.builtin")
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local open_with_trouble = require("trouble.sources.telescope").open
        telescope.setup({
            extensions = {
                ["ui-select"] = require("telescope.themes").get_dropdown({}),
            },
            defaults = {
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",  -- Smart case matching (case insensitive unless uppercase used)
                    "--no-ignore-vcs"
                },
                file_ignore_patterns = { 
                    "node_modules", "%.pyc", ".git/", "%.DS_Store",
                    "*.jpg", "*.jpeg", "*.png", "*.svg", "*.otf", "*.ttf"
                },
                layout_strategy = "horizontal",
                sorting_strategy = "ascending",
                -- Ghostty-optimized layout
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.6,  -- Wider preview for Ghostty
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                        preview_height = 0.6,
                    },
                    width = 0.9,   -- Use more screen space in Ghostty
                    height = 0.85,
                    preview_cutoff = 120,
                },
                path_display = { "truncate" },
                -- Ghostty handles these previews excellently
                preview = {
                    treesitter = true,
                    timeout = 250,
                },
                -- Enhanced mappings for productivity
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-t>"] = open_with_trouble,
                        ["<C-u>"] = false,  -- Ghostty handles C-u naturally
                        ["<C-d>"] = actions.delete_buffer,
                        ["<M-p>"] = actions.cycle_history_prev,
                        ["<M-n>"] = actions.cycle_history_next,
                    },
                    n = { 
                        ["<c-t>"] = open_with_trouble,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("ui-select")
        telescope.load_extension("fzf")
        -- telescope.load_extension("git_worktree")
        function SearchInFilesWithExtension(extension)
            require("telescope.builtin").find_files({
                prompt_title = "Buscar en archivos con extensión " .. extension,
                find_command = { "rg", "--files", "--iglob", "*." .. extension },
            })
        end

        vim.api.nvim_create_user_command("TelescopeFindFilesWithExt", function(opts)
            SearchInFilesWithExtension(opts.args)
        end, { nargs = 1 })

        function GrepInFilesWithExtension(extension)
            builtin.live_grep({
                prompt_title = "Buscar en archivos con extensión " .. extension,
                additional_args = function()
                    return { "--glob", "*." .. extension }
                end,
            })
        end

        vim.api.nvim_create_user_command("TelescopeGrepWithExt", function(opts)
            GrepInFilesWithExtension(opts.args)
        end, { nargs = 1 })

        -- Word search function with flexible options
        function WordSearch()
            builtin.live_grep({
                prompt_title = "Word Search (smart case, flexible matching)",
                additional_args = function()
                    return { "--smart-case" }
                end,
            })
        end

        -- Fuzzy search function (original behavior)
        function FuzzySearch()
            builtin.live_grep({
                prompt_title = "Fuzzy Search (smart case, partial matches)",
                additional_args = function()
                    return { "--smart-case" }
                end,
            })
        end
        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        -- File operations
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
        
        -- Search operations
        keymap.set("n", "<leader>fs", "<cmd>lua WordSearch()<cr>", { desc = "Word search (smart case, flexible)" })
        keymap.set("n", "<leader>fS", "<cmd>lua FuzzySearch()<cr>", { desc = "Fuzzy search (partial matches)" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
        
        -- Navigation
        keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jump list" })
        keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
        
        -- Diagnostics and Git
        keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
        
        -- Ghostty + macOS shortcuts
        keymap.set("n", "<D-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files (Cmd-P)" })
        keymap.set("n", "<D-f>", "<cmd>lua WordSearch()<cr>", { desc = "Flexible word search (Cmd-F)" })
        keymap.set("n", "<D-b>", "<cmd>Telescope buffers<cr>", { desc = "Buffers (Cmd-B)" })
        
        -- Enhanced telescope pickers
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
        keymap.set("n", "<leader>f:", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
        keymap.set("n", "<leader>ft", "<cmd>Telescope builtin<cr>", { desc = "Telescope builtin" })
        keymap.set("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Vim options" })
        keymap.set("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
        -- keymap.set(
        --     "n",
        --     "<leader>wt",
        --     "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        --     { desc = "Show worktrees" }
        -- )
        -- keymap.set(
        --     "n",
        --     "<leader>wa",
        --     "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        --     { desc = "Create worktree" }
        -- )
        vim.keymap.set("n", "<leader>fD", function()
            local search_dir = vim.fn.input("Search Directory: ", "", "file")
            local command = string.format([[Telescope live_grep search_dirs={'%s'}]], search_dir)
            vim.cmd(command)
        end, { desc = "Live grep in specified directory" })
        keymap.set("n", "<C-g>", builtin.git_files, { desc = "Show git files" })
        keymap.set("n", "<leader>tf", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffer fuzzy find" })
    end,
}
