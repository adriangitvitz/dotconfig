return {
    -- Fast JSON formatting and manipulation
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            enable = true,
            max_lines = 5,
            patterns = {
                json = {
                    "object",
                    "array",
                    "pair",
                },
            },
        },
    },
    
    -- High-performance JSON viewer and formatter
    {
        "gennaro-tedesco/nvim-jqx",
        ft = { "json", "yaml" },
        keys = {
            { "<leader>jq", "<cmd>JqxList<cr>", desc = "Jqx List" },
            { "<leader>jf", "<cmd>JqxQuery<cr>", desc = "Jqx Query" },
        },
        config = function()
            require("nvim-jqx").setup({
                geometry = {
                    width = 0.8,
                    height = 0.8,
                    wrap = true,
                },
                query_key = "jq",
                sort = false,
                use_quickfix = true,
            })
        end,
    },

    -- JSON path and navigation
    {
        "someone-stole-my-name/yaml-companion.nvim",
        ft = { "yaml", "yml" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    },

    -- Enhanced JSON syntax and folding
    {
        "creativenull/efmls-configs-nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        ft = { "json", "jsonc", "yaml", "yml" },
        config = function()
            -- JSON specific settings
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "json", "jsonc" },
                callback = function()
                    -- Performance optimizations for large JSON files
                    vim.opt_local.foldmethod = "syntax"
                    vim.opt_local.foldlevel = 2
                    vim.opt_local.foldenable = true
                    vim.opt_local.foldcolumn = "1"
                    
                    -- Faster syntax highlighting
                    vim.opt_local.synmaxcol = 500
                    vim.opt_local.regexpengine = 1
                    
                    -- Better search for JSON
                    vim.opt_local.iskeyword:append(":")
                    vim.opt_local.iskeyword:append(".")
                    
                    -- JSON-specific keymaps
                    local opts = { buffer = true, silent = true }
                    vim.keymap.set("n", "<leader>jj", ":%!jq .<CR>", opts)
                    vim.keymap.set("v", "<leader>jj", ":!jq .<CR>", opts)
                    vim.keymap.set("n", "<leader>jc", ":%!jq -c .<CR>", opts) -- compact
                    vim.keymap.set("n", "<leader>js", ":%!jq -S .<CR>", opts) -- sort keys
                    vim.keymap.set("n", "<leader>jv", ":split | enew | setfiletype json | 0put =json_encode(json_decode(join(getline(1,'$'), '\n')))<CR>", opts)
                end,
            })
        end,
    },

    -- Fast search in JSON files
    {
        "nvim-pack/nvim-spectre",
        keys = {
            { "<leader>Sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
            { "<leader>Sw", function() require("spectre").open_visual({select_word=true}) end, desc = "Search current word" },
            { "<leader>Sf", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file" },
        },
        config = function()
            require("spectre").setup({
                color_devicons = true,
                highlight = {
                    ui = "String",
                    search = "DiffDelete",
                    replace = "DiffAdd"
                },
                mapping = {
                    ['toggle_line'] = {
                        map = "dd",
                        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                        desc = "toggle item"
                    },
                    ['enter_file'] = {
                        map = "<cr>",
                        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                        desc = "goto current file"
                    },
                    ['send_to_qf'] = {
                        map = "<leader>q",
                        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                        desc = "send all item to quickfix"
                    },
                    ['replace_cmd'] = {
                        map = "<leader>c",
                        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                        desc = "input replace vim command"
                    },
                    ['show_option_menu'] = {
                        map = "<leader>o",
                        cmd = "<cmd>lua require('spectre').show_options()<CR>",
                        desc = "show option"
                    },
                    ['run_current_replace'] = {
                        map = "<leader>rc",
                        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                        desc = "replace current line"
                    },
                    ['run_replace'] = {
                        map = "<leader>R",
                        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                        desc = "replace all"
                    },
                },
                find_engine = {
                    ['rg'] = {
                        cmd = "rg",
                        args = {
                            '--color=never',
                            '--no-heading',
                            '--with-filename',
                            '--line-number',
                            '--column',
                        },
                        options = {
                            ['ignore-case'] = {
                                value = "--ignore-case",
                                icon = "[I]",
                                desc = "ignore case"
                            },
                            ['hidden'] = {
                                value = "--hidden",
                                desc = "hidden file",
                                icon = "[H]"
                            },
                        }
                    },
                },
                replace_engine = {
                    ['sed'] = {
                        cmd = "sed",
                        args = nil,
                        options = {
                            ['ignore-case'] = {
                                value = "--ignore-case",
                                icon = "[I]",
                                desc = "ignore case"
                            },
                        }
                    },
                },
                default = {
                    find = {
                        cmd = "rg",
                        options = {"ignore-case"}
                    },
                    replace = {
                        cmd = "sed"
                    }
                },
                replace_vim_cmd = "cdo",
                is_open_target_win = true,
                is_insert_mode = false,
            })
        end,
    }
}