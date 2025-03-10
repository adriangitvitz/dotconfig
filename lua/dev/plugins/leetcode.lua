return {
    "adriangitvitz/leetcode.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        -- "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- configuration goes here
        lang = "python3",
        vim.api.nvim_set_hl(0, "leetcode_dyn_p", { fg = "#787878" })
    },
}
