return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        -- local keymap = vim.keymap
        -- local opts = { noremap = true, silent = true }
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

        -- Custom border with rounded corners for LSP floating windows
        local lsp_border_chars = {
            { "╭", "LspFloatWinBorder" },
            { "─", "LspFloatWinBorder" },
            { "╮", "LspFloatWinBorder" },
            { "│", "LspFloatWinBorder" },
            { "╯", "LspFloatWinBorder" },
            { "─", "LspFloatWinBorder" },
            { "╰", "LspFloatWinBorder" },
            { "│", "LspFloatWinBorder" },
        }

        -- Set up custom highlight groups for LSP floating windows
        local function setup_lsp_float_highlights()
            -- Use your colorscheme's colors for consistent theming
            vim.api.nvim_set_hl(0, "LspFloatWinNormal", {
                bg = "#1C1E2D",     -- Your base color
                fg = "#F0F0F0",     -- Your text color
            })
            vim.api.nvim_set_hl(0, "LspFloatWinBorder", {
                bg = "#1C1E2D",     -- Match window background
                fg = "#F5C27D",     -- Your peach accent color
            })
            vim.api.nvim_set_hl(0, "LspFloatTitle", {
                bg = "#F5C27D",     -- Peach background for title
                fg = "#1C1E2D",     -- Dark text on light background
                bold = true,
            })
        end

        -- Apply highlights on colorscheme change
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = setup_lsp_float_highlights,
        })
        setup_lsp_float_highlights() -- Apply immediately

        -- Force override LSP handlers to ensure our custom borders are used
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or lsp_border_chars
            opts.max_width = opts.max_width or 80  
            opts.max_height = opts.max_height or 20
            opts.wrap = true
            opts.winblend = 0
            opts.winhighlight = "Normal:LspFloatWinNormal,FloatBorder:LspFloatWinBorder,FloatTitle:LspFloatTitle"
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Configure LSP hover and signature help windows
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = lsp_border_chars,
            title = " 󰋖 Documentation ",
            title_pos = "center", 
            focusable = true,
            close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
            max_width = 80,
            max_height = 20,
            wrap = true,
            silent = true,
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = lsp_border_chars,
            title = " 󰊕 Signature ",
            title_pos = "center",
            focusable = true,
            close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
            max_width = 80,
            max_height = 15,
            wrap = true,
            silent = true,
        })

        vim.diagnostic.config({
            signs            = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.WARN] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            update_in_insert = false,
            float            = {
                focused = false,
                style = "minimal",
                border = lsp_border_chars,
                source = "always",
                header = "",
                prefix = "",
                max_width = 80,
                max_height = 20,
                wrap = true,
                winhighlight = "Normal:LspFloatWinNormal,FloatBorder:LspFloatWinBorder",
            },
            virtual_text     = { 
                severity = { min = vim.diagnostic.severity.WARN },
                spacing = 2,
                prefix = "●",
                format = function(diagnostic)
                    -- Truncate long diagnostic messages for performance
                    if #diagnostic.message > 100 then
                        return diagnostic.message:sub(1, 97) .. "..."
                    end
                    return diagnostic.message
                end
            },
            underline        = true,
            severity_sort    = true,
        })

        -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- end

        local on_attach = function(client, bufnr)
            -- Performance optimization: throttle codelens refresh
            if client.server_capabilities.codeLensProvider then
                local timer = nil
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = function()
                        if timer then
                            timer:stop()
                        end
                        timer = vim.defer_fn(function()
                            vim.lsp.codelens.refresh()
                        end, 500) -- Throttle to 500ms
                    end,
                })
            end

            -- Performance: Disable expensive features for large files
            local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
            if file_size > 200 * 1024 then -- 200KB threshold
                client.server_capabilities.documentHighlightProvider = false
                client.server_capabilities.documentFormattingProvider = false
            end

            -- Language-specific optimizations
            if client.name == 'pyright' then
                -- Optimize for Python data science work
                local filetype = vim.bo[bufnr].filetype
                if filetype == "python" then
                    -- Check for data science imports in the file
                    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
                    local has_data_libs = false
                    for _, line in ipairs(lines) do
                        if line:match("import numpy") or line:match("import pandas") or 
                           line:match("from numpy") or line:match("from pandas") then
                            has_data_libs = true
                            break
                        end
                    end
                    
                    if has_data_libs then
                        -- Optimize completion for data science libraries
                        client.server_capabilities.completionProvider.triggerCharacters = { ".", "[", "(" }
                    end
                end
            end

            -- in lspconfig.lua on_attach
            local tb = require("telescope.builtin")

            vim.keymap.set("n", "gd", tb.lsp_definitions, { buffer = bufnr, desc = "Definitions" })
            vim.keymap.set("n", "gD", tb.lsp_type_definitions, { buffer = bufnr, desc = "Type Definitions" })
            vim.keymap.set("n", "gr", tb.lsp_references, { buffer = bufnr, desc = "References" })
            vim.keymap.set("n", "gi", tb.lsp_implementations, { buffer = bufnr, desc = "Implementations" })

            -- Enhanced hover with double K to focus the hover window
            local function enhanced_hover()
                local winid = vim.lsp.buf.hover()
                if winid then
                    vim.keymap.set("n", "K", function()
                        vim.api.nvim_set_current_win(winid)
                    end, { buffer = bufnr, desc = "Focus hover window" })
                end
            end
            vim.keymap.set("n", "K", enhanced_hover, { buffer = bufnr, desc = "Hover (K again to focus)" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Prev diagnostic" })
            vim.keymap.set("n", "<leader>dd", function() tb.diagnostics({ bufnr = 0 }) end,
                { buffer = bufnr, desc = "Buffer diagnostics" })
            vim.keymap.set("n", "<leader>cL", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run CodeLens" })
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
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                
                -- Performance optimization for large Python files
                local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
                if file_size > 500 * 1024 then -- 500KB
                    -- Reduce features for large files
                    client.server_capabilities.semanticTokensProvider = nil
                    client.server_capabilities.documentHighlightProvider = nil
                end
            end,
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
                    -- Performance improvements
                    disableLanguageServices = false,
                    disableTaggedHints = false,
                },
                python = {
                    venvPath = vim.fn.getcwd(),
                    venv = ".venv",
                    analysis = {
                        -- Performance optimizations
                        diagnosticMode = "openFilesOnly", -- Better performance than workspace
                        autoImportCompletions = true,
                        typeCheckingMode = "basic", -- Changed from "off" for better intellisense
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        
                        -- Numpy/Data Science optimizations
                        stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                        typeshedPaths = {},
                        
                        -- Performance settings for large codebases
                        indexing = true,
                        packageIndexDepths = {
                            {
                                name = "",
                                depth = 2,
                                includeAllSymbols = false
                            }
                        },
                        
                        -- Exclude problematic patterns that slow down numpy
                        exclude = {
                            "**/node_modules",
                            "**/__pycache__",
                            "**/.*",
                            "**/build",
                            "**/dist"
                        },
                        
                        -- Improve completion for data science libraries
                        extraPaths = {},
                        
                        -- Memory management
                        logLevel = "Information",
                        watchForSourceChanges = true,
                        watchForLibraryChanges = false, -- Disable for better performance
                        watchForConfigChanges = true,
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

        -- JSON LSP with performance optimizations
        lspconfig["jsonls"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                
                -- Disable LSP for very large JSON files
                local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
                if file_size > 1024 * 1024 then -- 1MB
                    client.stop()
                    return
                end
            end,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                    -- Performance settings
                    maxItemsComputed = 5000,
                    trace = { server = "off" },
                },
            },
            filetypes = { "json", "jsonc" },
        })

        -- YAML LSP (already configured but optimizing)
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
