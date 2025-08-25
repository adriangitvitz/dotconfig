return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.preselectSupport = true
        capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
        capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
        capabilities.textDocument.completion.completionItem.deprecatedSupport = true
        capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
        capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
        capabilities.textDocument.completion.completionItem.resolveSupport =
        { properties = { "documentation", "detail", "additionalTextEdits" } }
        capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

        vim.diagnostic.config({
            signs            = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.WARN] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            update_in_insert = true,
            float            = {
                focused = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            virtual_text     = true,
            underline        = true,
            severity_sort    = true,
        })

        -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- end

        local on_attach = function(client, bufnr)
            if client.server_capabilities.codeLensProvider then
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.codelens.refresh()
                    end,
                })
            end

            -- if client.name == 'ruff' then
            --     -- Disable hover in favor of Pyright
            --     client.server_capabilities.hoverProvider = false
            -- end

            -- require("navigator").setup({ client = client })

            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            -- opts.desc = "Go to declaratuon"
            -- keymap.set("n", "gD", vim.lsp.buf.definition, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = opts.desc })
            -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            if client.server_capabilities.implementationProvider then
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
            else -- pyright path
                keymap.set("n", "gi", "<cmd>Telescope lsp_definitions<CR>", opts)
            end

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

        -- lspconfig["ruff"].setup({
        --     capabilities = (function()
        --         capabilities.completionProvider = false
        --         return capabilities
        --     end)(),
        --     init_options = {
        --         settings = {
        --             configurationPreference = "filesystemFirst",
        --             logLevel = "debug",
        --             codeAction = {
        --                 disableRuleComment = {
        --                     enable = false
        --                 }
        --             },
        --             lint = {
        --                 enable = true,
        --                 select = { "F", "E", "W", "I", "C90" },
        --                 ignore = { "E501", "T201" }
        --             },
        --             format = {
        --                 enable = true,
        --                 docstringCodeStyle = "google",
        --                 args = { "--line-length=120" }
        --             }
        --         }
        --     },
        --     handlers = {
        --         ["textDocument/publishDiagnostics"] = vim.lsp.with(
        --             vim.lsp.diagnostic.on_publish_diagnostics, {
        --                 virtual_text = { prefix = "■", spacing = 2 }
        --             }
        --         )
        --     },
        --     commands = {
        --         RuffAutofix = {
        --             function()
        --                 vim.lsp.buf.execute_command {
        --                     command = 'ruff.applyAutofix',
        --                     arguments = {
        --                         { uri = vim.uri_from_bufnr(0) },
        --                     },
        --                 }
        --             end,
        --             description = 'Ruff: Fix all auto-fixable problems',
        --         },
        --         RuffOrganizeImports = {
        --             function()
        --                 vim.lsp.buf.execute_command {
        --                     command = 'ruff.applyOrganizeImports',
        --                     arguments = {
        --                         { uri = vim.uri_from_bufnr(0) },
        --                     },
        --                 }
        --             end,
        --             description = 'Ruff: Format imports',
        --         },
        --     },
        -- })

        local function organize_imports()
            local params = {
                command = "pyright.organizeimports",
                arguments = { vim.uri_from_bufnr(0) },
            }
            vim.lsp.buf.execute_command(params)
        end

        local function set_python_path(path)
            local clients = vim.lsp.get_clients({
                bufnr = vim.api.nvim_get_current_buf(),
                name = "pyright",
            })
            for _, client in ipairs(clients) do
                client.config.settings =
                    vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
                client.notify("workspace/didChangeConfiguration", { settings = nil })
            end
        end

        lspconfig["pyright"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_dir = function(fname)
                return util.root_pattern(unpack({
                    "pyproject.toml",
                    "setup.py",
                    "setup.cfg",
                    "requirements.txt",
                    "Pipfile",
                    "pyrightconfig.json",
                    ".git",
                }))(fname)
            end,
            settings = {
                pyright = {
                    disableOrganizeImports = true,
                },
                python = {
                    venvPath = vim.fn.getcwd(), -- project root
                    venv     = ".venv",
                    analysis = {
                        diagnosticMode         = "workspace", -- "openFilesOnly" | "workspace" :contentReference[oaicite:0]{index=0}
                        -- ignore = { "*" },
                        -- Enable autocompletion
                        autoImportCompletions  = true,
                        -- Improve completion quality
                        typeCheckingMode       = "off",
                        autoSearchPaths        = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
            commands = {
                PyrightOrganizeImports = {
                    organize_imports,
                    description = "Organize Imports",
                },
                PyrightSetPythonPath = {
                    set_python_path,
                    description = "Reconfigure pyright with the provided python path",
                    nargs = 1,
                    complete = "file",
                },
            },
            single_file_support = true,
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
            cmd          = { 'terraform-ls', 'serve' },
            filetypes    = { 'terraform', 'terraform-vars', 'hcl' }, -- tfvars/hcl need v0.35+
            root_dir     = util.root_pattern('.terraform', '.git', 'main.tf'),
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
                ['terraform-ls'] = {
                    excludeRootModules = {},     -- directories the server must ignore
                    experimentalFeatures = {
                        diagnostics      = true, -- inline validate/plan errors
                        moduleCompletion = true, -- auto-complete remote modules
                        stacks           = true, -- v0.35: completion for *.tfstack files
                    },
                },
                terraform = {
                    languageServer = {
                        logLevel = 'info', -- trace|debug|info|warn|error|off
                        maxNumberOfProblems = 100,
                    },
                },
            },

            -- Some knobs are still only in initOptions as of v0.36
            init_options = {
                experimentalFeatures = {
                    prefillRequiredFields = true, -- fills required attrs when you hit <CR>
                },
            },
        })

        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "css" },
        })

        -- lspconfig["marksman"].setup({
        --     filetypes = { "markdown", "quarto" },
        --     cmd = { "marksman", "server" },
        --     root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml", ".root"),
        --     settings = {
        --         markdown = {
        --             enableWikiLinks = true,
        --             enableFootnotes = true,
        --         }
        --     },
        -- })

        lspconfig["zls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "zig" },
        })

        lspconfig["gleam"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "gleam" },
        })


        -- lspconfig["elixirls"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = { "elixir" },
        -- })
    end
}
