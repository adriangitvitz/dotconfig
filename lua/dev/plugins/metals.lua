return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    ft = { "scala", "sbt" },
    opts = function()
        local metals_config = require("metals").bare_config()
        local map = vim.keymap.set
        metals_config.on_attach = function(client, bufnr)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            client.server_capabilities = vim.tbl_deep_extend(
                'force',
                client.server_capabilities,
                capabilities
            )
            map("n", "gD", vim.lsp.buf.definition)
            map("n", "K", vim.lsp.buf.hover)
            map("n", "gi", vim.lsp.buf.implementation)
            map("n", "gr", vim.lsp.buf.references)
            map("n", "gds", vim.lsp.buf.document_symbol)
            map("n", "gws", vim.lsp.buf.workspace_symbol)
            map("n", "<leader>cl", vim.lsp.codelens.run)
            map("n", "<leader>sh", vim.lsp.buf.signature_help)
            map("n", "<leader>rn", vim.lsp.buf.rename)
            map("n", "<leader>f", vim.lsp.buf.format)
            map("n", "<leader>ca", vim.lsp.buf.code_action)

            map("n", "<leader>ws", function()
                require("metals").hover_worksheet()
            end)

            -- all workspace diagnostics
            map("n", "<leader>aa", vim.diagnostic.setqflist)

            -- all workspace errors
            map("n", "<leader>ae", function()
                vim.diagnostic.setqflist({ severity = "E" })
            end)

            -- all workspace warnings
            map("n", "<leader>aw", function()
                vim.diagnostic.setqflist({ severity = "W" })
            end)

            -- buffer diagnostics only
            map("n", "<leader>d", vim.diagnostic.setloclist)

            map("n", "[c", function()
                vim.diagnostic.goto_prev({ wrap = false })
            end)

            map("n", "]c", function()
                vim.diagnostic.goto_next({ wrap = false })
            end)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
