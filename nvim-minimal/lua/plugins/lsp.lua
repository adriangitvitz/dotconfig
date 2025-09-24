-- Pure native LSP configuration using only Neovim's built-in LSP
-- This approach doesn't use nvim-lspconfig or mason at all
local function setup_native_lsp()
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Helper function to find project root
  local function find_root(patterns)
    local current_dir = vim.fn.expand('%:p:h')
    local root = vim.fs.find(patterns, {
      path = current_dir,
      upward = true,
    })[1]
    return root and vim.fn.fnamemodify(root, ':h') or current_dir
  end

  -- Python - Pyright
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
      local root_dir = find_root({ 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' })

      vim.lsp.start({
        name = 'pyright',
        cmd = { 'pyright-langserver', '--stdio' },
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true
            }
          }
        }
      })
    end,
  })

  -- Rust - rust-analyzer
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    callback = function()
      local root_dir = find_root({ 'Cargo.toml', 'rust-project.json', '.git' })

      vim.lsp.start({
        name = 'rust_analyzer',
        cmd = { 'rust-analyzer' },
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          }
        }
      })
    end,
  })

  -- Go - gopls
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'gomod', 'gohtmltmpl', 'gotexttmpl' },
    callback = function()
      local root_dir = find_root({ 'go.work', 'go.mod', '.git' })

      vim.lsp.start({
        name = 'gopls',
        cmd = { 'gopls' },
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              unreachable = true,
            },
            staticcheck = true,
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          }
        }
      })
    end,
  })

  -- TypeScript/JavaScript - ts_ls
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    callback = function()
      local root_dir = find_root({ 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' })

      vim.lsp.start({
        name = 'ts_ls',
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = root_dir,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          }
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      })
    end,
  })

  -- C/C++ - clangd
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    callback = function()
      local root_dir = find_root({ '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' })

      vim.lsp.start({
        name = 'clangd',
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        root_dir = root_dir,
        capabilities = capabilities,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
    end,
  })

  -- Java - jdtls
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = function()
      local root_dir = find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })

      vim.lsp.start({
        name = 'jdtls',
        cmd = { 'jdtls' },
        root_dir = root_dir,
        capabilities = capabilities,
      })
    end,
  })

  -- Global keybindings using LspAttach
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
  })

  -- Optimize diagnostics display
  vim.diagnostic.config({
    virtual_text = { severity = vim.diagnostic.severity.ERROR },
    update_in_insert = false,
    float = { border = "rounded" }
  })
end

return {
  -- Native LSP setup using blink.cmp
  {
    "saghen/blink.cmp",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      setup_native_lsp()
    end,
  }
}
