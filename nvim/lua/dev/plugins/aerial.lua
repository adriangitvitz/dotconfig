return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Code outline" },
        { "]a", "<cmd>AerialNext<cr>", desc = "Next symbol" },
        { "[a", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
        { "<leader>ao", "<cmd>AerialOpen<cr>", desc = "Open outline" },
        { "<leader>ac", "<cmd>AerialClose<cr>", desc = "Close outline" },
    },
    opts = {
        backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        layout = {
            width = 0.2,
            default_direction = "right",
            placement = "window",
        },
        attach_mode = "window",
        close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
        keymaps = {
            ["?"] = "actions.show_help",
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.jump",
            ["<2-LeftMouse>"] = "actions.jump",
            ["<C-v>"] = "actions.jump_vsplit",
            ["<C-s>"] = "actions.jump_split",
            ["p"] = "actions.scroll",
            ["<C-j>"] = "actions.down_and_scroll",
            ["<C-k>"] = "actions.up_and_scroll",
            ["{"] = "actions.prev",
            ["}"] = "actions.next",
            ["[["] = "actions.prev_up",
            ["]]"] = "actions.next_up",
            ["q"] = "actions.close",
            ["o"] = "actions.tree_toggle",
            ["za"] = "actions.tree_toggle",
            ["O"] = "actions.tree_toggle_recursive",
            ["zA"] = "actions.tree_toggle_recursive",
            ["l"] = "actions.tree_open",
            ["zo"] = "actions.tree_open",
            ["L"] = "actions.tree_open_recursive",
            ["zO"] = "actions.tree_open_recursive",
            ["h"] = "actions.tree_close",
            ["zc"] = "actions.tree_close",
            ["H"] = "actions.tree_close_recursive",
            ["zC"] = "actions.tree_close_recursive",
            ["zr"] = "actions.tree_increase_fold_level",
            ["zR"] = "actions.tree_open_all",
            ["zm"] = "actions.tree_decrease_fold_level",
            ["zM"] = "actions.tree_close_all",
            ["zx"] = "actions.tree_sync_folds",
            ["zX"] = "actions.tree_sync_folds",
        },
        -- Filter out symbols that are too noisy
        filter_kind = {
            "Class",
            "Constructor", 
            "Enum",
            "Function",
            "Interface",
            "Module",
            "Method",
            "Struct",
            "Variable",
            "Field",
            "Property",
        },
        -- Show box drawing characters for the tree hierarchy
        show_guides = true,
        -- Customize the characters used when show_guides = true
        guides = {
            mid_item = "├─",
            last_item = "└─",
            nested_top = "│ ",
            whitespace = "  ",
        },
        -- Set to false to remove the default keymaps for the aerial buffer
        default_keymaps = true,
        -- Disable on files this large
        disable_max_lines = 10000,
        disable_max_size = 2000000, -- Default 2MB
        -- A list of all symbols to display. Set to false to display all symbols.
        nerd_font = "auto",
    },
    config = function(_, opts)
        require("aerial").setup(opts)
        
        -- Auto-open for certain filetypes
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "lua", "javascript", "typescript", "rust", "go" },
            callback = function()
                -- Only auto-open for files larger than 50 lines
                if vim.api.nvim_buf_line_count(0) > 50 then
                    vim.schedule(function()
                        require("aerial").open()
                    end)
                end
            end,
        })
    end,
}