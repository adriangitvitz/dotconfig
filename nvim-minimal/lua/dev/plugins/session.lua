return {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
        -- Will use Telescope if installed or a vim.ui.select picker otherwise
        { '<leader>wr', '<cmd>SessionSearch<CR>',  desc = 'Session search' },
        { '<leader>ws', '<cmd>SessionSave<CR>',    desc = 'Save session' },
        { '<leader>wS', '<cmd>SessionRestore<CR>', desc = 'Restore session' },
        -- { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
    opts = {
        suppressed_dirs = { '~/', '~/Downloads', '/' },
        bypass_save_filetypes = { 'alpha', 'dashboard' },
        auto_save = false,
        use_git_branch = true,
        pre_save_cmds = {
            function()
                -- If Neotree is open, close it
                -- vim.cmd 'Neotree close'

                -- Close any tabs with these filetypes
                local fts_to_match = { 'Neogit', 'Diffview' }

                -- Look for any windows with buffers that match fts_to_match
                local function should_close_tab(tabpage)
                    local windows = vim.api.nvim_tabpage_list_wins(tabpage)
                    for _, window in ipairs(windows) do
                        local buffer = vim.api.nvim_win_get_buf(window)
                        local filetype = vim.api.nvim_get_option_value('filetype', { buf = buffer })
                        for _, v in ipairs(fts_to_match) do
                            if string.find(filetype, '^' .. v) then
                                return true
                            end
                        end
                    end
                    return false
                end

                -- Close any tabs that have the filetypes in fts_to_match
                local tabpages = vim.api.nvim_list_tabpages()
                for _, tabpage in ipairs(tabpages) do
                    if should_close_tab(tabpage) then
                        local tabNr = vim.api.nvim_tabpage_get_number(tabpage)
                        vim.cmd('tabclose ' .. tabNr)
                    end
                end
            end,
        },
        post_cwd_changed_cmds = {
            function()
                require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
                vim.cmd('redrawtabline')
            end
        },
        session_lens = {
            previewer = false,
            mappings = {
                -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                delete_session = { "i", "<C-D>" },
                alternate_session = { "i", "<C-S>" },
                copy_session = { "i", "<C-Y>" },
            },
        }
    }
}
