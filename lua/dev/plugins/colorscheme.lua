return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = "mocha",
                dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
            term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false,           -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,         -- percentage of the shade to apply to the inactive window
            },
            no_italic = true,              -- Force no italic
            no_bold = false,               -- Force no bold
            no_underline = false,          -- Force no underline
            styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = {},             -- Change the style of comments
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {
                all = {
                    rosewater = "#f5e0dc",
                    flamingo = "#f2cdcd",
                    pink = "#a9d9a0",
                    mauve = "#f5f2eb",
                    red = "#d8c545",
                    maroon = "#c0b796",
                    peach = "#fab387",
                    yellow = "#f9e2af",
                    green = "#c0b796",
                    teal = "#d8c545",
                    sky = "#d8c545",
                    sapphire = "#fab387",
                    blue = "#d68d2a",
                    lavender = "#f0eae0",
                    text = "#f0eae0",
                    subtext1 = "#bac2de",
                    subtext0 = "#a6adc8",
                    overlay2 = "#c0b796",
                    overlay1 = "#7f849c",
                    overlay0 = "#c0b796",
                    surface2 = "#585b70",
                    surface1 = "#45475a",
                    surface0 = "#313244",
                    base = "#1e1e2e",
                    mantle = "#181825",
                    crust = "#11111b",
                },
            },
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                dashboard = true,
                diffview = true,
                lsp_saga = true,
                markdown = true,
                mason = false,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                snacks = {
                    enabled = true,
                    indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                },
                telescope = {
                    enabled = false,
                    -- style = "nvchad"
                },
                which_key = false,
                lsp_trouble = true,
                blink_cmp = {
                    style = 'bordered',
                }
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}
