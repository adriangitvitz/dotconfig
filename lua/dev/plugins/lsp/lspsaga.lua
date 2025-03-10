return {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
        require('lspsaga').setup({
            hover = {
                max_width = 0.9,
                max_height = 0.9,
                open_link = "gx",
                open_browser = "!open",
                async_request = true
            },
            symbol_in_winbar = {
                enable = false
            },
            lightbulb = {
                enable = false
            }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
