return {
    -- Lazy loading for JSON-heavy files
    {
        "folke/neoconf.nvim",
        lazy = false,
        config = function()
            require("neoconf").setup({
                -- JSON schema validation for config files
                filetype_jsonc = true,
            })
        end,
    },

    -- Enhanced JSON handling with lazy loading
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- Add performance settings for JSON
            if opts.highlight then
                opts.highlight.additional_vim_regex_highlighting = { "json" }
                opts.highlight.disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end
            end
            return opts
        end,
    }
}