return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        preset = "classic", -- "classic", "modern", or "helix"
        icons = {
            group = (vim.g.fallback_icons_enabled and "+") or "",
            rules = false,
            separator = "-",
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
        vim.api.nvim_set_hl(0, "WhichKey", { link = "Function" }) -- Example override
        vim.api.nvim_set_hl(0, "WhichKeyGroup", { link = "Keyword" })
        vim.api.nvim_set_hl(0, "WhichKeyDesc", { link = "Identifier" })
        vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "FloatBorder" })
    end,
}
