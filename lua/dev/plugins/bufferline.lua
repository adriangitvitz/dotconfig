return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { '<leader>bn', '<cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },
        { '<leader>bp', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous Buffer' },
        { '<leader>bc', '<cmd>BufferLinePickClose<CR>', desc = 'Pick buffer to close' }
    },
    event = "VeryLazy",
    opts = {
        options = {
            mode = "buffers",
            separator_style = "slant",
            always_show_bufferline = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
            color_icons = true
        },
    },
    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
                offsets = {
                    {
                        filetype = "neo-tree",  -- or "NvimTree", etc.
                        text = "File Explorer", -- optional title (centered by default)
                        highlight = "Directory",
                        separator = true        -- show a border separator
                    }
                },
            }
        })
        vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    end
}
