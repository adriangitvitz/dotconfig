return {
  {
    "echasnovski/mini.statusline",
    version = "*",
    event = "VeryLazy",
    config = function()
      local statusline = require("mini.statusline")

      statusline.setup({
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diff = statusline.section_diff({ trunc_width = 75 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
          inactive = function()
            local filename = statusline.section_filename({ trunc_width = 140 })
            return statusline.combine_groups({
              { hl = "MiniStatuslineInactive", strings = { filename } },
            })
          end,
        },
        use_icons = true,
        set_vim_settings = false, -- Don't override existing settings
      })

      -- Custom highlight groups for accessibility
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Mode-specific highlights with high contrast monochrome colors
          vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#ffffff", bg = "#444444", bold = true })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = "#000000", bg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#ffffff", bg = "#666666", bold = true })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "#ffffff", bg = "#333333", bold = true })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "#ffffff", bg = "#555555", bold = true })
          vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = "#ffffff", bg = "#777777", bold = true })

          -- Content highlights
          vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#cccccc", bg = "#222222" })
          vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = "#aaaaaa", bg = "#2a2a2a" })
          vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = "#999999", bg = "#1a1a1a" })
          vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = "#666666", bg = "#1a1a1a" })
        end,
      })

      -- Trigger the highlight setup immediately
      vim.cmd("doautocmd ColorScheme")
    end,
  }
}