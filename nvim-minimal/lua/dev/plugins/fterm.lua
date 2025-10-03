return {
    'numToStr/FTerm.nvim',
    keys = {
        { '<C-\\>',     '<CMD>lua require("FTerm").toggle()<CR>', desc = 'Toggle terminal' },
        { '<leader>tT', '<CMD>lua require("FTerm").open()<CR>',   desc = 'Open terminal' },
        { '<leader>tC', '<CMD>lua require("FTerm").close()<CR>',  desc = 'Close terminal' },
        { '<c-o>t',     '<CMD>lua require("FTerm").toggle()<CR>', desc = 'Toggle Terminal' },
        { '<leader>tH', '<CMD>lua _horizontal_term_toggle()<CR>', desc = 'Horizontal terminal' },
        { '<leader>tV', '<CMD>lua _vertical_term_toggle()<CR>',   desc = 'Vertical terminal' },
        { '<leader>zd', '<CMD>lua _lazydocker_toggle()<CR>',      desc = 'Lazydocker' },
        { '<leader>vG', '<CMD>lua _ghdash_toggle()<CR>',          desc = 'Git Dash' },
    },
    config = function()
        require('FTerm').setup({
            border = 'rounded',
            dimensions = {
                height = 0.8,
                width = 0.8,
            },
            -- Optimized for keratoconus - better contrast
            hl = 'Normal',
        })

        -- Create specialized terminal instances
        local fterm = require('FTerm')

        -- Horizontal terminal
        local horizontal_term = fterm:new({
            ft = 'FTerm',
            cmd = os.getenv('SHELL'),
            dimensions = {
                height = 0.3,
                width = 1.0,
                x = 0.0,
                y = 0.7,
            },
        })

        -- Vertical terminal
        local vertical_term = fterm:new({
            ft = 'FTerm',
            cmd = os.getenv('SHELL'),
            dimensions = {
                height = 1.0,
                width = 0.3,
                x = 0.7,
                y = 0.0,
            },
        })

        -- Lazydocker terminal
        local lazydocker = fterm:new({
            ft = 'FTerm',
            cmd = 'lazydocker',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        })

        -- GitHub dashboard terminal
        local ghdash = fterm:new({
            ft = 'FTerm',
            cmd = 'gh dash',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        })

        -- Global functions for keybindings
        function _G._horizontal_term_toggle()
            horizontal_term:toggle()
        end

        function _G._vertical_term_toggle()
            vertical_term:toggle()
        end

        function _G._lazydocker_toggle()
            lazydocker:toggle()
        end

        function _G._ghdash_toggle()
            ghdash:toggle()
        end

        -- Terminal mode keymaps for better navigation
        vim.api.nvim_create_autocmd('TermOpen', {
            pattern = '*',
            callback = function()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            end,
        })
    end,
}

