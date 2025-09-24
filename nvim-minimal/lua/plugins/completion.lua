return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = 'cargo +nightly build --release',
    version = "1.*",
    opts = {
      completion = {
        menu = { auto_show = false }, -- Disable auto popup
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = false }, -- For manual-only workflow
      },
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show" },
        ["<C-y>"] = { "accept" },
        ["<C-e>"] = { "hide" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono"
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          python = { "lsp", "path" },
          rust = { "lsp", "path" },
          go = { "lsp", "path" },
          javascript = { "lsp", "path" },
          typescript = { "lsp", "path" },
          java = { "lsp", "path" },
          c = { "lsp", "path" },
          cpp = { "lsp", "path" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
