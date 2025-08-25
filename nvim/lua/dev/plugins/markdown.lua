return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
    config = function()
        require("render-markdown").setup({
            file_types = { 'markdown', 'quarto' },
            latex = {
                enabled = true,
                render_modes = true, -- Disable conflicting render modes [3][12]
                converter = 'latex2text',
                -- converter_args = {   -- Enhanced conversion parameters [10]
                --     "--mathjax",
                --     "--relaxed"
                -- },
                highlight = 'RenderMarkdownMath',
                top_pad = 1, -- Adjust spacing for better rendering [3]
                bottom_pad = 1,
                -- packages = { -- Required LaTeX packages [10]
                --     "amsmath",
                --     "amssymb",
                --     "mathtools"
                -- }
            },
            -- highlights = {
            --     RenderMarkdownMath = {
            --         fg = "#8faf9f",
            --         bg = "#242424",
            --         italic = true -- Add math-specific styling [8]
            --     },
            --     heading = {
            --         backgrounds = { "#242424", "#2a2a2a", "#303030" }, -- Progressive contrast
            --         foregrounds = { "#8faf9f", "#7f9f8f", "#6f8f7f" }  -- Desaturated greens
            --     }
            -- }
        })
    end
}
