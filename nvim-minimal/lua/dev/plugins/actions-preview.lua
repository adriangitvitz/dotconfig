return {
    "aznhe21/actions-preview.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>ca",
            function() 
                require("actions-preview").code_actions() 
            end,
            mode = { "v", "n" },
            desc = "Code Action Preview",
        },
    },
    opts = {
        -- Priority list of preferred backend
        backend = { "telescope", "nui" },
        
        -- Options related to telescope.nvim backend
        telescope = {
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                width = 0.8,
                height = 0.9,
                prompt_position = "top",
                preview_cutoff = 20,
                preview_height = function(_, _, max_lines)
                    return max_lines - 15
                end,
            },
        },
        
        -- Options related to nui.nvim backend
        nui = {
            -- Options for nui Layout
            layout = {
                position = "50%",
                size = {
                    width = "60%",
                    height = "90%",
                },
                min_width = 40,
                min_height = 10,
                relative = "editor",
            },
            -- Options for preview area
            preview = {
                size = "60%",
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
            -- Options for selection area
            select = {
                size = "40%",
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
        },
        
        -- Options for diff preview
        diff = {
            algorithm = "patience",
            ignore_whitespace = true,
        },
        
        -- Whether to highlight the range of the code action
        highlight_command = {
            -- Whether to highlight the range of the code action in the buffer
            enable = true,
            -- Highlight group for the code action range
            highlight_group = "DiffAdd",
            -- Time to wait before clearing the highlight
            auto_clear = true,
            clear_delay = 2000, -- in milliseconds
        },
    },
}