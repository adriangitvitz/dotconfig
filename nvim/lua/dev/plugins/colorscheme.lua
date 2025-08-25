return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            background = {
                light = "mocha",
                dark = "mocha",
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = true, -- Recommended for keratoconus: italics can worsen ghosting/blurring
            no_bold = false,
            no_underline = false,
            styles = {
                comments = {},
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
            },
            color_overrides = {
                mocha = {
                    -- Base colors & High Contrast Adjustments
                    -- Background: #1C1E2D

                    -- Primary Text
                    text      = "#F0F0F0",
                    rosewater = "#E6E6E6",
                    flamingo  = "#EAEAEA",
                    green     = "#E6E6E6", -- Using rosewater for consistency

                    -- Accent Color (WCAG AAA)
                    peach     = "#F5C27D",
                    yellow    = "#F5C27D",

                    -- Reds (WCAG AAA)
                    red       = "#FF9E9E",
                    maroon    = "#EE9A9A",

                    -- High Contrast Grays (All WCAG AAA)
                    pink      = "#D2D2D2",
                    mauve     = "#C9C9C9",
                    subtext1  = "#C9C9C9",
                    teal      = "#C0C0C0",
                    subtext0  = "#C0C0C0",
                    sky       = "#B8B8B8",
                    lavender  = "#B4B4B4",
                    sapphire  = "#B0B0B0",
                    blue      = "#A9A9A9",


                    -- UI colors (All WCAG AA or better, subtly tinted blue for differentiation)
                    overlay2 = "#AAB0D4",
                    overlay1 = "#9DA3C0",
                    overlay0 = "#8A90B3",

                    surface2 = "#8F95B9",
                    surface1 = "#8187AC",
                    surface0 = "#848AC0",

                    -- Background tones
                    base     = "#1C1E2D", -- Setting base explicitly to your preferred background
                    mantle   = "#181825",
                    crust    = "#11111b",
                },
            },
            custom_highlights = {
                -- Override syntax highlighting for high contrast approach

                -- Keywords (Bright Accent, Bold for emphasis)
                ["@keyword"] = { fg = "#F5C27D", style = { "bold" } },
                ["@keyword.function"] = { fg = "#F5C27D", style = { "bold" } },
                ["@keyword.type"] = { fg = "#F5C27D", style = { "bold" } },

                -- Functions (Bright Accent)
                ["@function"] = { fg = "#F5C27D" },
                ["@function.method"] = { fg = "#F5C27D" },
                ["@function.method.call"] = { fg = "#F5C27D" },
                ["@function.builtin"] = { fg = "#F5C27D" },
                ["@method"] = { fg = "#F5C27D" },

                -- Strings (Bright White)
                ["@string"] = { fg = "#E6E6E6" },
                ["@string.escape"] = { fg = "#F7F7F7" },

                -- Variables (Slightly off-white for distinction)
                ["@variable"] = { fg = "#F0F0F0" },
                ["@variable.builtin"] = { fg = "#F0F0F0" },
                ["@variable.member"] = { fg = "#D2D2D2" },
                ["@variable.parameter"] = { fg = "#D2D2D2" },

                -- Properties and Fields
                ["@property"] = { fg = "#EAEAEA" }, -- Using Flamingo
                ["@field"] = { fg = "#EAEAEA" },

                -- Types, Numbers, Booleans (Bright White)
                ["@type"] = { fg = "#FBF8FA" },
                ["@type.builtin"] = { fg = "#FBF8FA" },
                ["@number"] = { fg = "#FBF8FA" },
                ["@boolean"] = { fg = "#FBF8FA" },
                ["@constant"] = { fg = "#C9C9C9" },

                -- Comments (Medium Gray, high contrast but less prominent)
                ["@comment"] = { fg = "#B8B8B8" }, -- Sky
                ["Comment"] = { fg = "#B8B8B8" },
                ["@comment.documentation"] = { fg = "#B8B8B8" },

                -- Operators and Punctuation (Medium Gray)
                ["@operator"] = { fg = "#C0C0C0" }, -- Teal
                ["@punctuation"] = { fg = "#C0C0C0" },
                ["@punctuation.bracket"] = { fg = "#B0B0B0" },
                ["@punctuation.delimiter"] = { fg = "#A9A9A9" },

                -- Tags and Attributes
                ["@tag"] = { fg = "#FBF8FA" },
                ["@attribute"] = { fg = "#F7F7F7" },
                ["@constructor"] = { fg = "#FBF8FA" },
                ["@constructor.python"] = { fg = "#FBF8FA" },

                -- LSP semantic tokens
                ["@lsp.type.class"] = { fg = "#FBF8FA" },
                ["@lsp.type.function"] = { fg = "#F5C27D" },
                ["@lsp.type.method"] = { fg = "#F5C27D" },
                ["@lsp.type.variable"] = { fg = "#F0F0F0" },
                ["@lsp.type.property"] = { fg = "#EAEAEA" },
                ["@lsp.type.parameter"] = { fg = "#D2D2D2" },

                -- Diagnostics
                DiagnosticError = { fg = "#FF9E9E" },
                DiagnosticWarn = { fg = "#F5C27D" },
                DiagnosticInfo = { fg = "#B0B0B0" },
                DiagnosticHint = { fg = "#B4B4B4" },

                -- UI elements
                LineNr = { fg = "#8A90B3" },                           -- overlay0
                CursorLineNr = { fg = "#F5C27D", style = { "bold" } }, -- Peach
                CursorLine = { bg = "#26283D" },                       -- Slightly lighter than background for visibility
                Visual = { bg = "#5A5E75" },                           -- Using a darker surface color for visual selection
                Search = { bg = "#C0C0C0", fg = "#1C1E2D" },
                IncSearch = { bg = "#F5C27D", fg = "#1C1E2D" },
            },
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                mini = { enabled = true, indentscope_color = "", },
                dashboard = true,
                diffview = true,
                lsp_saga = true,
                markdown = true,
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
                    inlay_hints = { background = true },
                },
                snacks = { enabled = true, indent_scope_color = "" },
                lsp_trouble = true,
                blink_cmp = { style = 'bordered' },
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
