-- Advanced persistent bookmark system optimized for monorepos and multiple sessions
return {
    "tomasky/bookmarks.nvim",
    keys = {
        { "<leader>mm", "<cmd>lua require('bookmarks').bookmark_toggle()<cr>", desc = "Toggle bookmark" },
        { "<leader>mi", "<cmd>lua require('bookmarks').bookmark_ann()<cr>", desc = "Add/edit bookmark annotation" },
        { "<leader>ma", "<cmd>lua require('bookmarks').bookmark_list()<cr>", desc = "Show all bookmarks" },
        { "<leader>mn", "<cmd>lua require('bookmarks').bookmark_next()<cr>", desc = "Next bookmark" },
        { "<leader>mp", "<cmd>lua require('bookmarks').bookmark_prev()<cr>", desc = "Previous bookmark" },
        { "<leader>mc", "<cmd>lua require('bookmarks').bookmark_clean()<cr>", desc = "Clean invalid bookmarks" },
        { "<leader>mx", "<cmd>lua require('bookmarks').bookmark_clear_all()<cr>", desc = "Clear all bookmarks" },
        { "<leader>hd", "<cmd>lua require('bookmarks').bookmark_ann()<cr>", desc = "Add bookmark with annotation" },
        { "<leader>hm", "<cmd>lua require('bookmarks').bookmark_list()<cr>", desc = "Show bookmark list" },
    },
    event = "VimEnter",
    config = function()
        require('bookmarks').setup({
            -- save bookmark file the given global directory, not current working directory
            -- if not set, it will be saved in current working directory(./.bookmarks)
            save_file = vim.fn.expand "$HOME/.bookmarks", -- global bookmarks file

            keywords = {
                ["@t"] = "☑️ ", -- mark annotation with @t will display with ☑️
                ["@w"] = "⚠️ ", -- mark annotation with @w will display with ⚠️
                ["@f"] = "⭐ ", -- mark annotation with @f will display with ⭐
                ["@n"] = "📝 ", -- mark annotation with @n will display with 📝
                ["@b"] = "🐞 ", -- mark annotation with @b will display with 🐞
                ["@i"] = "💡 ", -- mark annotation with @i will display with 💡
                ["@r"] = "🔴 ", -- mark annotation with @r will display with 🔴
                ["@g"] = "🟢 ", -- mark annotation with @g will display with 🟢
            },

            on_attach = function(bufnr)
                local bm = require "bookmarks"
                local map = vim.keymap.set

                -- Additional buffer-local shortcuts
                map("n", "mm", bm.bookmark_toggle)
                map("n", "mi", bm.bookmark_ann)
                map("n", "ma", bm.bookmark_list)
                map("n", "mn", bm.bookmark_next)
                map("n", "mp", bm.bookmark_prev)
                map("n", "mc", bm.bookmark_clean)
                map("n", "mx", bm.bookmark_clear_all)
            end
        })

        -- Integration with telescope if available
        pcall(function()
            require('telescope').load_extension('bookmarks')
            vim.keymap.set('n', '<leader>fk', '<cmd>Telescope bookmarks list<cr>',
                { desc = 'Search bookmarks' })
        end)
    end,
}
