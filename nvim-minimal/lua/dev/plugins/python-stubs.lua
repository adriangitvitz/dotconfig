return {
    -- Python performance enhancements
    {
        "neovim/nvim-lspconfig", 
        ft = "python",
        config = function()
            -- Python-specific performance autocmds
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "python",
                callback = function(ev)
                    local bufnr = ev.buf
                    
                    -- Performance settings for Python files
                    vim.bo[bufnr].tabstop = 4
                    vim.bo[bufnr].shiftwidth = 4
                    vim.bo[bufnr].softtabstop = 4
                    vim.bo[bufnr].expandtab = true
                    
                    -- Optimize folding for Python classes and functions
                    vim.wo.foldmethod = "indent"
                    vim.wo.foldlevel = 2
                    
                    -- Performance keymaps for Python
                    local opts = { buffer = bufnr, silent = true }
                    vim.keymap.set("n", "<leader>pi", ":PyrightOrganizeImports<CR>", opts)
                    vim.keymap.set("n", "<leader>pr", ":LspRestart pyright<CR>", opts)
                end,
            })
        end,
    },
    
    -- Optional: Add Ruff as separate LSP (commented out to avoid conflicts)
    -- Uncomment if you want ultra-fast linting alongside Pyright
    --[[
    {
        "neovim/nvim-lspconfig",
        ft = "python",
        config = function()
            require("lspconfig").ruff_lsp.setup({
                on_attach = function(client, bufnr)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                    
                    -- Performance optimization: disable for very large files
                    local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
                    if file_size > 1024 * 1024 then -- 1MB
                        client.stop()
                        return
                    end
                end,
                capabilities = require('blink.cmp').get_lsp_capabilities(),
                init_options = {
                    settings = {
                        args = { "--extend-ignore", "E501,W503,E203" },
                        logLevel = "warn",
                    },
                },
            })
        end,
    }
    --]]
}