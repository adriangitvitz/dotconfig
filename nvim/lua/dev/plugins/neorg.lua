return {
    "nvim-neorg/neorg",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
        {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                if not opts.ensure_installed then
                    opts.ensure_installed = {}
                end
                if type(opts.ensure_installed) == "table" then
                    vim.list_extend(opts.ensure_installed, { "norg" })
                end
                return opts
            end,
        },
    },
    ft = "norg",
    cmd = "Neorg",
    keys = {
        { "<leader>nw", "<cmd>Neorg workspace<cr>",                  desc = "Neorg Workspace" },
        { "<leader>nr", "<cmd>Neorg return<cr>",                     desc = "Return to Neorg" },
        { "<leader>ni", "<cmd>Neorg index<cr>",                      desc = "Neorg Index" },
        { "<leader>nj", "<cmd>Neorg journal<cr>",                    desc = "Neorg Journal" },
        { "<leader>nt", "<cmd>Neorg journal today<cr>",              desc = "Today's Journal" },
        { "<leader>ny", "<cmd>Neorg journal yesterday<cr>",          desc = "Yesterday's Journal" },
        { "<leader>nm", "<cmd>Neorg journal tomorrow<cr>",           desc = "Tomorrow's Journal" },
        { "<leader>nf", "<cmd>Telescope neorg find_norg_files<cr>",  desc = "Find Neorg Files" },
        { "<leader>nh", "<cmd>Telescope neorg search_headings<cr>",  desc = "Search Headings" },
        { "<leader>nl", "<cmd>Telescope neorg insert_link<cr>",      desc = "Insert Link" },
        { "<leader>nF", "<cmd>Telescope neorg insert_file_link<cr>", desc = "Insert File Link" },
    },
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    icon_preset = "diamond",
                    icons = {
                        todo = {
                            undone = {
                                icon = " ",
                            },
                            pending = {
                                icon = "󰥔 ",
                            },
                            done = {
                                icon = " ",
                            },
                            cancelled = {
                                icon = " ",
                            },
                        },
                        list = {
                            icons = { " ", " ", " ", " ", " ", " " },
                        },
                    },
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/Documents/Notes",
                        work = "~/Documents/Notes/Work",
                        personal = "~/Documents/Notes/Personal",
                        projects = "~/Documents/Notes/Projects",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.integrations.nvim-cmp"] = {},
            ["core.journal"] = {
                config = {
                    strategy = "nested",
                    workspace = "notes",
                },
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = "<Leader>n",
                },
            },
            ["core.summary"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = "all",
                },
            },
            ["core.qol.toc"] = {},
            ["core.qol.todo_items"] = {},
            ["core.looking-glass"] = {},
            ["core.presenter"] = {
                config = {
                    zen_mode = "zen-mode",
                },
            },
            ["core.integrations.telescope"] = {},
        },
    },
    config = function(_, opts)
        require("neorg").setup(opts)

        -- Ensure directories exist
        local notes_dir = vim.fn.expand("~/Documents/Notes")
        vim.fn.mkdir(notes_dir, "p")
        vim.fn.mkdir(notes_dir .. "/Work", "p")
        vim.fn.mkdir(notes_dir .. "/Personal", "p")
        vim.fn.mkdir(notes_dir .. "/Projects", "p")

        -- Auto-save Neorg files
        vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
            pattern = "*.norg",
            command = "silent! write",
        })

        -- Better concealment for note-taking
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                vim.opt_local.conceallevel = 2
                vim.opt_local.concealcursor = "nc"
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
            end,
        })

        -- Simple note-taking keymaps (without complex functions)
        vim.keymap.set('n', '<leader>nq', '<cmd>edit ~/Documents/Notes/quick_notes.norg<cr>', { desc = 'Quick notes' })
        vim.keymap.set('n', '<leader>na', '<cmd>edit ~/Documents/Notes/reminders.norg<cr>', { desc = 'Reminders' })
        vim.keymap.set('n', '<leader>nc', '<cmd>edit ~/Documents/Notes/reminders.norg<cr>', { desc = 'Check reminders' })

        -- Install norg parser if not available
        vim.schedule(function()
            if not pcall(vim.treesitter.language.inspect, "norg") then
                vim.notify("Installing Neorg treesitter parser...", vim.log.levels.INFO)
                vim.cmd("TSInstall norg")
            end
        end)
    end,
}

