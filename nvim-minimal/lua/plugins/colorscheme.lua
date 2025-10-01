return {
  "palette.nvim",
  dev = true,
  priority = 1000,
  config = function()
    require("palette").setup({
      -- Use the keratoconus-optimized palettes
      palettes = {
        main = "keratoconus",
        accent = "keratoconus",
        state = "keratoconus",
      },

      -- Recommended settings for keratoconus
      italics = true,
      transparent_background = true,  -- Solid backgrounds reduce eye strain

      -- Optional: Enable caching for better performance
      caching = true,
      cache_dir = vim.fn.stdpath("cache") .. "/palette",
    })

    vim.cmd([[colorscheme palette]])
  end,
}
