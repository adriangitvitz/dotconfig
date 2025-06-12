return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        { "<c-o>t",     desc = "Toggle Terminal (Bottom)" },
        { "<c-o>T",     desc = "Toggle Terminal (Tab)" },
        { "<leader>zd", "<cmd>lua _lazydocker_toggle()<CR>", desc = "Lazydocker" },
        { "<leader>vG", "<cmd>lua _ghdash_toggle()<CR>",     desc = "Git Dash" },
    },
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            size = 20,
            hide_numbers = true,
            open_mapping = [[<c-o>t]], -- This opens at the bottom
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 0.1,
            start_in_insert = true,
            persist_size = true,
            direction = "horizontal", -- Default direction (bottom)
            close_on_exit = true,
            float_opts = {
                border = "curved",
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
                title_pos = "center",
            },
        })

        -- Create a terminal instance that opens in a new tab
        local Terminal = require("toggleterm.terminal").Terminal
        local tab_terminal = Terminal:new({
            direction = "tab",
            close_on_exit = true,
        })

        -- Function to toggle terminal in a new tab
        function _G.toggle_term_tab()
            tab_terminal:toggle()
        end

        -- Keymap for tab terminal
        vim.keymap.set("n", "<c-o>T", "<cmd>lua toggle_term_tab()<CR>", { desc = "Toggle Terminal (Tab)" })

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        local ghdash = Terminal:new({
            cmd = "gh dash",
            hidden = true,
            direction = "float",
            close_on_exit = true,
            float_opts = { width = vim.o.columns, height = vim.o.lines },
        })
        function _ghdash_toggle()
            ghdash:toggle()
        end

        local lazydocker =
            Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float", close_on_exit = true })

        function _lazydocker_toggle()
            lazydocker:toggle()
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
}
