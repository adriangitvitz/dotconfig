return {
    "f-person/git-blame.nvim",
    cmd = {
        "GitBlameToggle",
        "GitBlameEnable", 
        "GitBlameOpenCommitURL",
        "GitBlameOpenFileURL",
        "GitBlameCopySHA",
        "GitBlameCopyCommitURL",
    },
    keys = {
        { "<leader>gB", "<cmd>GitBlameToggle<cr>", desc = "Git blame toggle" },
        { "<leader>gbc", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open commit URL" },
        { "<leader>gby", "<cmd>GitBlameCopySHA<cr>", desc = "Copy commit SHA" },
        { "<leader>gbf", "<cmd>GitBlameOpenFileURL<cr>", desc = "Open file URL" },
    },
    opts = {
        -- Whether blame is enabled by default
        enabled = false,
        
        -- Message template for git blame
        message_template = " <summary> • <date> • <author>",
        
        -- Date format for git blame  
        date_format = "%Y-%m-%d %H:%M",
        
        -- Virtual text column to display blame info
        virtual_text_column = 1,
        
        -- Highlight group for git blame virtual text
        highlight_group = "Comment",
        
        -- Set extmark options
        set_extmark_options = {
            hl_mode = "combine",
            priority = 100,
        },
        
        -- Delay before showing blame info (in milliseconds)
        delay = 1000,
        
        -- Use GitBlame colors
        use_blame_commit_file_urls = true,
        
        -- Template for commit summary
        display_virtual_text = true,
        
        -- Ignore whitespace when computing blame
        ignore_whitespace = false,
        
        -- Show blame info in floating window on cursor hold
        show_blame_commit_file_urls = true,
        
        -- Git blame format args
        git_blame_format = "%an - %ar - %s",
        
        -- Custom git blame command
        git_blame_command = nil, -- Uses default 'git blame'
        
        -- Schedule function for async blame
        schedule_event = "CursorHold",
        
        -- Clear blame on these events
        clear_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
        
        -- File types to disable git blame
        disabled_filetypes = {
            "alpha",
            "dashboard", 
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
        },
    },
    config = function(_, opts)
        require("gitblame").setup(opts)
        
        -- Auto-enable for git repos
        vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
            pattern = "*",
            callback = function()
                -- Check if we're in a git repo
                local git_dir = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("%s+", "")
                if git_dir == "true" then
                    -- Only enable for certain file types
                    local ft = vim.bo.filetype
                    local enabled_fts = {
                        "lua", "python", "javascript", "typescript", 
                        "rust", "go", "java", "c", "cpp", "sh", 
                        "yaml", "json", "markdown", "vim"
                    }
                    
                    for _, enabled_ft in ipairs(enabled_fts) do
                        if ft == enabled_ft then
                            -- Don't auto-enable, just make it available
                            break
                        end
                    end
                end
            end,
        })
        
        -- Keybinding to quickly enable/disable for current session
        vim.keymap.set("n", "<leader>gbt", function()
            if vim.g.gitblame_enabled then
                vim.cmd("GitBlameDisable")
                vim.notify("Git blame disabled", vim.log.levels.INFO)
            else
                vim.cmd("GitBlameEnable") 
                vim.notify("Git blame enabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle git blame for session" })
    end,
}