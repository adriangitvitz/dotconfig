return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diff viewer" },
    },
    config = function()
        require("diffview").setup({
            view = {
                default = {
                    layout = "diff2_vertical",
                },
                file_history = {
                    layout = "diff2_vertical",
                },
            }
        })
    end,
}
