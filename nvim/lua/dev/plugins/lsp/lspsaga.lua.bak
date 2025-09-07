return {
    'adriangitvitz/lspsaga.nvim',
    branch = "dev",
    event = "LspAttach",
    config = function()
        require('lspsaga').setup({
            -- Disable lightbulb which can cause flickering
            lightbulb = {
                enable = false,
                enable_in_insert = false,
                sign = false,
                virtual_text = false,
            },
            -- Disable diagnostic virtual text which can cause flickering
            diagnostic = {
                on_insert = false,
                on_insert_follow = false,
                show_code_action = true,
                show_source = true,
                keys = {
                    exec_action = 'o',
                    quit = 'q',
                },
            },
            hover = {
                max_width = 0.9,
                max_height = 0.9,
                open_link = "gx",
                open_browser = "!open",
                async_request = true
            },
            progress = {
                enable = false
            },
            symbol_in_winbar = {
                enable = false
            }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
