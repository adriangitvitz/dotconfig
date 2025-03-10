return {
    "projectlaunch.nvim",
    as = "projectlaunch.nvim",
    dev = true,
    config = function()
        local projectlaunch = require("projectlaunch")
        projectlaunch.setup({
            split_default_width = 80,
            split_focus_on_open = false,
            config_path = ".projectlaunch.json",
            auto_reload_config = true
        })

        -- open the main menu
        vim.keymap.set('n', "<leader>ll", projectlaunch.toggle_main_menu,
            { noremap = true, expr = false, buffer = false, desc = "Project: Main menu" })

        -- open the floating window terminal viewer
        vim.keymap.set('n', "<leader>lf", projectlaunch.toggle_float,
            { noremap = true, expr = false, buffer = false, desc = "Project: Float terminal" })

        -- open the split window terminal viewer
        vim.keymap.set('n', "<leader>ls", projectlaunch.toggle_split,
            { noremap = true, expr = false, buffer = false, desc = "Project: Split terminal" })

        -- show the next or previous terminals in the open viewer
        vim.keymap.set('n', "<leader>ln", projectlaunch.show_next,
            { noremap = true, expr = false, buffer = false, desc = "Project: Next terminal" })
        vim.keymap.set('n', "<leader>lm", projectlaunch.show_prev,
            { noremap = true, expr = false, buffer = false, desc = "Project: Prev terminal" })

        -- restart the command running in the currently open split terminal
        vim.keymap.set('n', "<leader>lr", projectlaunch.restart_command_in_split,
            { noremap = true, expr = false, buffer = false, desc = "Project: Restart" })
    end
}
