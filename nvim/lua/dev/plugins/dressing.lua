return {
    'stevearc/dressing.nvim',
    config = function()
        require('dressing').setup({
            select = { backend = { "telescope", "builtin" } },
            input = {
                enabled = true,      -- Enable floating input
                default_prompt = "Input: ",
                border = "rounded",  -- Customize border style (e.g., "single", "double", "rounded")
                relative = "editor", -- Position relative to the cursor
                prefer_width = 40,   -- Set preferred width for the input window
                winblend = 10,       -- Transparency level
            },
        })
    end,
}
