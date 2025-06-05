return {
    {
        "adriangitvitz/jellybeans.nvim",
        branch = "local",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
    },
    {
        "adriangitvitz/zenburn.nvim",
        config = function()
            require("zenburn").setup()
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
            vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
        end
    },
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("lackluster").setup({
                disable_plugin = {
                    bufferline = true,
                },
                tweak_background = {
                    normal = "none",
                }
            })
        end
    }
}
