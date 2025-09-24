return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme("zenwritten") -- Pure monochrome version

      -- Additional accessibility overrides with accent colors
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Accent colors for keratoconus accessibility
          local peach_accent = "#F8D2C9"  -- Soft peach accent
          local mint_accent = "#9CCFD8"   -- Soft mint green accent

          -- Make background transparent to use terminal background
          vim.api.nvim_set_hl(0, "Normal", { fg = "#ffffff", bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#ffffff", bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalNC", { fg = "#ffffff", bg = "NONE" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#666666", bg = "NONE" })
          vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#333333" })
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "CursorColumn", { bg = "NONE" })

          -- High contrast essentials (monochrome base)
          vim.api.nvim_set_hl(0, "Visual", { bg = "#444444", fg = "#ffffff" })
          vim.api.nvim_set_hl(0, "Search", { bg = "#000000", fg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#666666" })

          -- Base syntax with monochrome + typography
          vim.api.nvim_set_hl(0, "Comment", { fg = "#888888", italic = true })
          vim.api.nvim_set_hl(0, "Keyword", { fg = "#ffffff", bold = true })

          -- Language constructs with accent colors
          -- Functions - Peach accent
          vim.api.nvim_set_hl(0, "Function", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@function", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@function.call", { fg = peach_accent })
          vim.api.nvim_set_hl(0, "@function.builtin", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@method", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@method.call", { fg = peach_accent })

          -- Classes and Types - Mint accent
          vim.api.nvim_set_hl(0, "Type", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type.builtin", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type.definition", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@class", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@structure", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "StorageClass", { fg = mint_accent, bold = true })

          -- Import/Include statements - Peach keywords, Mint modules
          vim.api.nvim_set_hl(0, "Include", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "PreProc", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@include", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@preproc", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.include", { fg = peach_accent, bold = true })

          -- Variables - Light monochrome (things that hold values)
          vim.api.nvim_set_hl(0, "Identifier", { fg = "#dddddd" })
          vim.api.nvim_set_hl(0, "@variable", { fg = "#dddddd" })
          vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#cccccc", italic = true })
          vim.api.nvim_set_hl(0, "@variable.member", { fg = "#dddddd" })
          vim.api.nvim_set_hl(0, "@property", { fg = "#dddddd" })
          vim.api.nvim_set_hl(0, "@field", { fg = "#dddddd" })

          -- Values and literals - Darker monochrome (actual data)
          vim.api.nvim_set_hl(0, "Constant", { fg = "#aaaaaa" })
          vim.api.nvim_set_hl(0, "@constant", { fg = "#aaaaaa" })
          vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#bbbbbb", bold = true })
          vim.api.nvim_set_hl(0, "String", { fg = "#999999" })
          vim.api.nvim_set_hl(0, "@string", { fg = "#999999" })
          vim.api.nvim_set_hl(0, "@string.escape", { fg = "#aaaaaa", bold = true })
          vim.api.nvim_set_hl(0, "Number", { fg = "#aaaaaa" })
          vim.api.nvim_set_hl(0, "@number", { fg = "#aaaaaa" })
          vim.api.nvim_set_hl(0, "@number.float", { fg = "#aaaaaa" })
          vim.api.nvim_set_hl(0, "Boolean", { fg = "#bbbbbb", bold = true })
          vim.api.nvim_set_hl(0, "@boolean", { fg = "#bbbbbb", bold = true })

          -- Null/None/Nil values - Even more muted
          vim.api.nvim_set_hl(0, "@constant.builtin.null", { fg = "#888888", italic = true })
          vim.api.nvim_set_hl(0, "@constant.builtin.none", { fg = "#888888", italic = true })
          vim.api.nvim_set_hl(0, "@constant.builtin.nil", { fg = "#888888", italic = true })

          -- Language-specific enhancements
          -- Python
          vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type.builtin.python", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import.python", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@module.python", { fg = mint_accent })

          -- Rust
          vim.api.nvim_set_hl(0, "@function.macro.rust", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type.rust", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import.rust", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@module.rust", { fg = mint_accent })

          -- Go
          vim.api.nvim_set_hl(0, "@function.builtin.go", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@type.builtin.go", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import.go", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@module.go", { fg = mint_accent })

          -- JavaScript/TypeScript
          vim.api.nvim_set_hl(0, "@constructor.javascript", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@constructor.typescript", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import.javascript", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@keyword.import.typescript", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@module.javascript", { fg = mint_accent })
          vim.api.nvim_set_hl(0, "@module.typescript", { fg = mint_accent })

          -- C/C++
          vim.api.nvim_set_hl(0, "@preproc.include.c", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@preproc.include.cpp", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@string.special.path", { fg = mint_accent })

          -- Java
          vim.api.nvim_set_hl(0, "@keyword.import.java", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@module.java", { fg = mint_accent })

          -- LSP semantic tokens (if supported)
          vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = peach_accent, bold = true })
          vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@lsp.type.struct", { fg = mint_accent, bold = true })
          vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = mint_accent, bold = true })

          -- Diagnostics with subtle coloring
          vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff6666" })
          vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffcc66" })
          vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#66ccff" })
          vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#999999" })
        end,
      })
    end
  },

  -- Alternative: Modus for WCAG AAA compliance
  {
    "miikanissi/modus-themes.nvim",
    enabled = false,  -- Enable if preferred over zenbones
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "auto",
        variant = "default",
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
        },
      })
    end
  }
}