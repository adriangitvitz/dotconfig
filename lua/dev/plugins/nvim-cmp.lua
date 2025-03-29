return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path",   -- source for file system paths
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",         -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "onsails/lspkind.nvim",     -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local compare = require("cmp.config.compare")

        require("luasnip.loaders.from_vscode").lazy_load()

        local source_mapping = {
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[Sig]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
            nvim_lua = "[Lua]",
        }

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            -- Better duplicate handling - items with value 0 won't show duplicates
            duplicates = {
                nvim_lsp = 0,
                luasnip = 0,
                buffer = 0,
                path = 0,
            },
            matching = {
                disallow_fuzzy_matching = false,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            mapping = cmp.mapping.preset.insert({
                -- your mappings are good
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- Use priority instead of group_index for clearer precedence
            sources = cmp.config.sources({
                { name = "neorg" },
                { name = 'nvim_lsp_signature_help' },
                {
                    name = 'nvim_lsp',
                    entry_filter = function(entry, ctx)
                        local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                        if kind == "Text" then
                            return false
                        end
                        return true
                    end
                },
                { name = "luasnip" },
                { name = 'nvim_lua' },
                {
                    name = 'buffer',
                    keyword_length = 3,
                    options = {
                        get_bufnrs = function()
                            -- Complete from visible buffers
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end
                    }
                },
                { name = 'path' },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    -- Use a better sorting strategy
                    -- This will help deduplicate items by preferring exact matches
                    compare.exact,
                    compare.score,
                    -- This comparator will group items by source
                    function(entry1, entry2)
                        local kind1 = entry1:get_kind()
                        local kind2 = entry2:get_kind()
                        if kind1 ~= kind2 then
                            return kind1 - kind2 < 0
                        end
                        return nil
                    end,
                    compare.recently_used,
                    compare.locality,
                    compare.sort_text,
                    compare.offset,
                    compare.kind,
                    compare.length,
                    compare.order,
                },
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = source_mapping[entry.source.name]

                    if entry.source.name == "nvim_lsp" then
                        if entry.completion_item.detail and entry.completion_item.detail ~= "" then
                            vim_item.menu = entry.completion_item.detail
                        end
                    end

                    return lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    })(entry, vim_item)
                end,
            },
        })
    end,
}
-- { name = "nvim_lsp", priority = 1000 },
-- { name = "luasnip", priority = 750 }, -- snippets
-- { name = "buffer", priority = 500 }, -- text within current buffer
-- { name = "path", priority = 250 }, -- file system paths
