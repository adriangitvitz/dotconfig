return {
    {
        "folke/todo-comments.nvim",
        event = { "VeryLazy" },
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<leader>tt", ":TodoTrouble<CR>",   desc = "TodoTrouble",   noremap = true, silent = true },
            { "<leader>tc", ":TodoTelescope<CR>", desc = "TodoTelescope", noremap = true, silent = true },
        },
        opts = {}, --needed!
    },
}
