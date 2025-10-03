return -- lazy.nvim
{
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            hover = { enabled = false },      -- Let our custom LSP handler take precedence
            signature = { enabled = false },  -- Let our custom LSP handler take precedence
            progress = { enabled = false },
            message = { enabled = false },
            smart_move = { enabled = false },
            -- override = {
            --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            --     ["vim.lsp.util.stylize_markdown"] = true,
            --     ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            -- },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = false,      -- disable to prevent search interference
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- enable border for hover docs and signature help
        },
        messages = {
            enabled = false
        },
        notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = false,
            view = "notify",
        },
        cmdline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {},              -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
                -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                -- view: (default is cmdline view)
                -- opts: any options passed to the view
                -- icon_hl_group: optional hl_group for the icon
                -- title: set to anything or empty string to hide
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
                -- lua = false, -- to disable a format, set to `false`
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}
