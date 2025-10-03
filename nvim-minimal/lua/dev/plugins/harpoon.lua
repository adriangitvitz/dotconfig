return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
        local keys = {
            {
                "<leader>ha",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon Add File",
            },
            {
                "<leader>hh",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Quick Menu",
            },
        }

        -- macOS Cmd shortcuts for Ghostty
        for i = 1, 4 do
            table.insert(keys, {
                "<D-" .. i .. ">",
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon to File " .. i,
            })
        end

        -- Leader-based fallbacks
        for i = 1, 4 do
            table.insert(keys, {
                "<leader>" .. i,
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon to File " .. i,
            })
        end

        return keys
    end,
    opts = {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
            save_on_change = true,
            enter_on_sendcmd = false,
            tmux_autoclose_windows = false,
            excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
            mark_branch = false,
            key = function()
                return vim.loop.cwd()
            end,
        },
    },
    config = function(_, opts)
        require("harpoon"):setup(opts)
    end,
}

