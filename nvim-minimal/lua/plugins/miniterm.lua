return {
    'miniterm.nvim',
    dev = true,
    keys = {
        { '<C-\\>',     function() require("miniterm").toggle() end, desc = 'Toggle terminal' },
        { '<leader>tT', function() require("miniterm").open() end,   desc = 'Open terminal' },
        { '<leader>tC', function() require("miniterm").close() end,  desc = 'Close terminal' },
        { '<c-o>t',     function() require("miniterm").toggle() end, desc = 'Toggle Terminal' },
        { '<leader>tH', '<CMD>lua _horizontal_term_toggle()<CR>', desc = 'Horizontal terminal' },
        { '<leader>tV', '<CMD>lua _vertical_term_toggle()<CR>',   desc = 'Vertical terminal' },
        { '<leader>zd', '<CMD>lua _lazydocker_toggle()<CR>',      desc = 'Lazydocker' },
        { '<leader>vG', '<CMD>lua _ghdash_toggle()<CR>',          desc = 'Git Dash' },
    },
    config = function()
        require('miniterm').setup({
            border = 'rounded',
            dimensions = {
                height = 0.8,
                width = 0.8,
            },
            hl = 'Normal',
        })
    end,
}