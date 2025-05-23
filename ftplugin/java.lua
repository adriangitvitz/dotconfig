local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local java_cmd = vim.fn.executable('java') == 1 and 'java' or nil
if not java_cmd then
    print("Java not found in PATH. Please install Java.")
    return
end

local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local path_to_lsp = jdtls_path .. "/config_mac_arm/"
local path_to_plugins = jdtls_path .. "/plugins/"
-- local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_*.jar"
local path_to_jar = path_to_plugins .. "org.eclipse.osgi_3.23.0.v20241212-0858.jar"

local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if not root_dir then
    root_dir = vim.fn.getcwd()
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace') .. project_name


local function on_attach(client, buffer)
    local opts = { buffer = buffer, remap = false }

    -- Navigation
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
    vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)

    -- Documentation
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    vim.keymap.set("n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>vd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

    -- Code actions
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    vim.keymap.set("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

    -- Rename
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

    -- Outline
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

    -- Call hierarchy
    vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
    vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)

    -- Enable LSPSaga's UI enhancements
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end


-- local function on_attach(client, buffer)
--     local opts = { buffer = buffer, remap = false }
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
--     vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
-- end


local config = {
    on_attach = on_attach,
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(path_to_jar),
        '-configuration', path_to_lsp,
        '-data', workspace_dir,
    },
    root_dir = root_dir,
    capabilities = capabilities,
    settings = {
        init_options = {
            bundles = {},
            extendedClientCapabilities = {
                progressReportProvider = true,
                classFileContentsSupport = true,
                overrideMethodsPromptSupport = true,
                hashCodeEqualsPromptSupport = true,
                advancedOrganizeImportsSupport = true,
                generateConstructorsPromptSupport = true,
                generateDelegateMethodsPromptSupport = true,
                advancedExtractRefactoringSupport = true,
            },
        },
        java = {
            configuration           = {
                flags = {
                    allow_incremental_sync = true,
                    debounce_text_changes = 150,
                    async_attach = true
                },
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
                        default = true
                    },
                }
            },
            project                 = {
                importOnFirstTimeStartup = "automatic",
                importHint = true,
                referencedLibraries = {
                    "lib/**/*.jar",
                },
            },
            completion              = {
                favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    "org.mockito.Mockito.*",
                    "org.mockito.ArgumentMatchers.*",
                    "org.mockito.Answers.*"
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org"
                },
            },
            sources                 = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            inlayHints              = { parameterNames = { enabled = "all" } },
            maven                   = {
                downloadSources = true
            },
            implementationsCodeLens = {
                enabled = true
            },
            referencesCodeLens      = {
                enabled = true
            },
            references              = {
                includeDecompiledSources = true,
            },
            codeGeneration          = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        }
    }
}

require('jdtls').start_or_attach(config)

vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
