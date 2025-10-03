return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters = {
                ruff_format = {
                    command = "ruff",
                    args = { "format", "--stdin-filename", "$FILENAME", "-" },
                    cwd = require("conform.util").root_file({ "pyproject.toml", ".ruff.toml" }),
                    range_args = function(ctx)
                        return { "--range", ctx.range.start_line, ctx.range.end_line }
                    end,
                },
                ruff_fix = {
                    command = "ruff",
                    args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
                }
            },
            formatters_by_ft = {
                java = { "google-java-format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier", "eslint" },
                typescriptreact = { "prettier", "eslint" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                -- yaml = { "yamlfmt" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "ruff_format", "ruff_fix" },
                go = { "goimports", "gofumpt" },
                -- sh = { "shfmt" },
                -- proto = { "buf" },
                hcl = { "hclfmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
