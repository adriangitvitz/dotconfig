-- return {
--     "adriangitvitz/zenburn.nvim",
--     config = function()
--         require("zenburn").setup()
--         vim.cmd("colorscheme zenburn")
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
--         vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
--         vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
--         vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
--     end
-- }
return {
    "adriangitvitz/jellybeans.nvim",
    branch = "local",
    lazy = false,
    priority = 1000,
    opts = {
        transparent = true,
    },
    config = function()
        vim.cmd [[colorscheme jellybeans-mono]]
    end
}
