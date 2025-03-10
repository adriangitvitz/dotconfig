return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvimdev/lspsaga.nvim", -- Enhanced UI features
        "hrsh7th/cmp-nvim-lsp",
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local capabilities = cmp_nvim_lsp.default_capabilities()
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local on_attach = function(client, bufnr)
            if client.server_capabilities.codeLensProvider then
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.codelens.refresh()
                    end,
                })
            end

            -- require("navigator").setup({ client = client })

            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = opts.desc })
            -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, desc = opts.desc })
            -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { buffer = bufnr, desc = opts.desc })
            -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, desc = opts.desc })
            -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufnr, desc = opts.desc })
            -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufnr, desc = opts.desc })
            -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = opts.desc })
            -- keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Show Codelens"
            keymap.set("n", "cd", vim.lsp.codelens.run, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

            opts.desc = "Hierarchy Visualization"
            keymap.set("n", "<leader>th", "<cmd>Lspsaga peek_type_definition<CR>", { buffer = bufnr, desc = opts.desc })
            -- opts.desc = "Format with LSP"
            -- keymap.set("n", "<leader>lf", vim.lsp.buf.format({ async = false }), opts) -- mapping to restart lsp if necessary
        end


        lspconfig["ts_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["rust_analyzer"].setup({
            cmd = { "rust-analyzer" },
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "rust" },
            root_dir = function(fname)
                return util.root_pattern("Cargo.toml")(fname) or util.path.dirname(fname)
            end,
            settings = {
                ["rust_analyzer"] = {
                    cargo = {
                        allFeatures = true,
                    },
                },
            },
        })

        lspconfig["gopls"].setup({
            cmd = { "gopls" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    codelenses = {
                        generate = true,   -- Generates code for methods, interfaces
                        gc_details = true, -- Show detailed info about garbage collection
                        test = true,       -- Add the ability to run tests
                    },
                },
            },
        })

        lspconfig["ruff"].setup({
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                    logLevel = "debug",
                    codeAction = {
                        disableRuleComment = {
                            enable = false
                        }
                    },
                    lint = {
                        enable = true,
                        select = { "F", "E", "W", "I", "C90" },
                        ignore = { "E501", "T201" }
                    },
                    format = {
                        enable = true,
                        docstringCodeStyle = "google",
                        args = { "--line-length=120" }
                    }
                }
            },
            handlers = {
                ["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, {
                        virtual_text = { prefix = "■", spacing = 2 }
                    }
                )
            },
            commands = {
                RuffAutofix = {
                    function()
                        vim.lsp.buf.execute_command {
                            command = 'ruff.applyAutofix',
                            arguments = {
                                { uri = vim.uri_from_bufnr(0) },
                            },
                        }
                    end,
                    description = 'Ruff: Fix all auto-fixable problems',
                },
                RuffOrganizeImports = {
                    function()
                        vim.lsp.buf.execute_command {
                            command = 'ruff.applyOrganizeImports',
                            arguments = {
                                { uri = vim.uri_from_bufnr(0) },
                            },
                        }
                    end,
                    description = 'Ruff: Format imports',
                },
            },
        })

        lspconfig["pylsp"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        jedi_hover = { enabled = true }, -- Must be enabled[10]
                        jedi_signature_help = { enabled = true },
                        jedi_completion = {
                            fuzzy = true,
                            eager = true,
                            cache_for = { "numpy", "pandas", "torch" }
                        },
                        preload = {
                            enabled = true,
                            modules = { "numpy", "pandas" }
                        },
                        -- Disable competing functionality
                        pycodestyle = { enabled = false },
                        pyflakes = { enabled = false },
                        mccabe = { enabled = false },
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        -- Configure Ruff integration
                        ruff = {
                            hover = { enabled = false }, -- Delegate to jedi[1]
                            enabled = true,
                            formatEnabled = true,
                            extendSelect = { "I" },
                            lineLength = 120,
                            targetVersion = "py311"
                        }
                    }
                }
            },
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        lspconfig["yamlls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "yaml", "yml" },
            settings = {
                yaml = {
                    format = {
                        enabled = true
                    },
                    schemas = {
                        -- kubernetes = { 'k8s**.yaml', 'kube*/*.yaml' },
                        kubernetes = "*k8s*.{yml,yaml}",
                        ["file:///Users/adriannajera/.config/schemas/kind.schema.json"] = "*.kind.yaml",
                        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
                        "*api*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                        "*docker-compose*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
                        "*flow*.{yml,yaml}",
                    },
                }
            }
        })

        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "c", "cpp", "objc", "objcpp" }
        })

        lspconfig["eslint"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        })

        lspconfig["terraformls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "terraform", "tf" },
            cmd = { "terraform-ls", "serve" },
            root_dir = function(fname)
                return util.root_pattern(unpack({ "*.tf", "*.tfvars" }))(fname)
            end,
        })

        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "css" },
        })

        lspconfig["marksman"].setup({
            filetypes = { "markdown", "quarto" },
            cmd = { "marksman", "server" },
            root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml", ".root"),
            settings = {
                markdown = {
                    enableWikiLinks = true,
                    enableFootnotes = true,
                }
            },
        })

        lspconfig["zls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "zig" },
        })

        -- lspconfig["elixirls"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = { "elixir" },
        -- })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client ~= nil and client.name == "ruff" then
                    -- Delegate to PyLSP
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.renameProvider = false
                elseif client ~= nil and client.name == "pylsp" then
                    -- Delegate to Ruff
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.codeActionProvider = false
                end
            end
        })
    end
}
