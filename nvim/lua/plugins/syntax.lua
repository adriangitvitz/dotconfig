return {
  -- Disable tree-sitter if installed for performance
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,  -- Completely disable tree-sitter
  },

  -- Language-specific syntax optimizations
  {
    "rust-lang/rust.vim",
    ft = "rust",
    config = function()
      vim.g.rust_conceal = 0
      vim.g.rust_fold = 0
    end
  }
}