  return {
    "miasma.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme miasma")
    end
  }
