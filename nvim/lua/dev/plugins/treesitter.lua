return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        cmd = {
            "TSBufDisable",
            "TSBufEnable",
            "TSBufToggle",
            "TSDisable",
            "TSEnable",
            "TSToggle",
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSModuleInfo",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
        },
        opts = {
            auto_install = false, -- Currently bugged. Use [:TSInstall all] and [:TSUpdate all]
            ensure_installed = {
                "c3",
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "rust",
                "go",
                "zig",
                "gomod",
                "gosum",
                "python",
                "cpp",
                "c",
                "comment",
                "elixir",
                "latex"
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = function(lang, buf)
                    return lang == "scheme" -- Temporary disable until fixed
                end
            },
            matchup = {
                enable = true,
                enable_quotes = true,
                disable = function(_, bufnr) return utils.is_big_file(bufnr) end,
            },
            incremental_selection = { enable = true },
            indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ak"] = { query = "@block.outer", desc = "around block" },
                        ["ik"] = { query = "@block.inner", desc = "inside block" },
                        ["ac"] = { query = "@class.outer", desc = "around class" },
                        ["ic"] = { query = "@class.inner", desc = "inside class" },
                        ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
                        ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
                        ["af"] = { query = "@function.outer", desc = "around function " },
                        ["if"] = { query = "@function.inner", desc = "inside function " },
                        ["al"] = { query = "@loop.outer", desc = "around loop" },
                        ["il"] = { query = "@loop.inner", desc = "inside loop" },
                        ["aa"] = { query = "@parameter.outer", desc = "around argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]k"] = { query = "@block.outer", desc = "Next block start" },
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
                    },
                    goto_next_end = {
                        ["]K"] = { query = "@block.outer", desc = "Next block end" },
                        ["]F"] = { query = "@function.outer", desc = "Next function end" },
                        ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
                    },
                    goto_previous_start = {
                        ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
                    },
                    goto_previous_end = {
                        ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                        ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        [">K"] = { query = "@block.outer", desc = "Swap next block" },
                        [">F"] = { query = "@function.outer", desc = "Swap next function" },
                        [">A"] = { query = "@parameter.inner", desc = "Swap next parameter" },
                    },
                    swap_previous = {
                        ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
                        ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
                        ["<A"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
                    },
                },
            },
        },
        config = function(_, opts)
            local treesitter = require("nvim-treesitter.configs")
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config["c3"] = {
                install_info = {
                    url = "https://github.com/c3lang/tree-sitter-c3",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "main",
                },
                sync_install = false, -- Set to true if you want to install synchronously
                auto_install = true,  -- Automatically install when opening a file
                filetype = "c3",      -- if filetype does not match the parser name
            }
            treesitter.setup(opts)
            vim.treesitter.language.register("markdown", "octo")
        end,
    },
}
