return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        }
                    },
                    ["core.integrations.nvim-cmp"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/Documents/Personal/norg",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            }

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end
    }
}
