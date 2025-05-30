return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            PATH = "prepend",
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "ts_ls",
                "lua_ls",
                "clangd",
                "jdtls",
                -- "java-debug-adapter",
                -- "java-test",
                "lua_ls",
                -- "pylsp",
                "terraformls",
                "yamlls",
                -- "yamlfmt",
                "eslint",
                -- "marksman"
            },
            automatic_installation = true, -- not the same as ensure_installed
        })
    end,
}
