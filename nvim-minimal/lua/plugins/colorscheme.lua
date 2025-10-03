return {
  "gruvbox.nvim",
  dev = true,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      transparent_mode = true,
      undercurl = false,
      underline = false,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      contrast = "soft"
    })
    vim.cmd([[colorscheme gruvbox]])
  end,
}
