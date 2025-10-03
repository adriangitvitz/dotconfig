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

                    -- Accent Color (WCAG AAA) - Warmer tone, less blue light for keratoconus
                    peach     = "#F8D2C9",
                    yellow    = "#F8D2C9",

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

                -- Keywords (Warmer Accent, Bold for emphasis - better for keratoconus)
                ["@keyword"] = { fg = "#F8D2C9", style = { "bold" } },
                ["@keyword.function"] = { fg = "#F8D2C9", style = { "bold" } },
                ["@keyword.type"] = { fg = "#F8D2C9", style = { "bold" } },

                -- Functions (Warmer Accent - reduces blue light strain)
                ["@function"] = { fg = "#F8D2C9" },
                ["@function.method"] = { fg = "#F8D2C9" },
                ["@function.method.call"] = { fg = "#F8D2C9" },
                ["@function.builtin"] = { fg = "#F8D2C9" },
                ["@method"] = { fg = "#F8D2C9" },

                -- Strings (Bright White)
                ["@string"] = { fg = "#E6E6E6" },
                ["@string.escape"] = { fg = "#F7F7F7" },

                -- Variables (Brighter colors for better readability)
                ["@variable"] = { fg = "#F0F0F0" },
                ["@variable.builtin"] = { fg = "#F0F0F0" },
                ["@variable.member"] = { fg = "#E8E8E8" },     -- Brighter than D2D2D2
                ["@variable.parameter"] = { fg = "#E5E5E5" },  -- Brighter than D2D2D2

                -- Properties and Fields
                ["@property"] = { fg = "#EAEAEA" }, -- Using Flamingo
                ["@field"] = { fg = "#EAEAEA" },

                -- Types, Numbers, Booleans (Bright White)
                ["@type"] = { fg = "#FBF8FA" },
                ["@type.builtin"] = { fg = "#FBF8FA" },
                ["@number"] = { fg = "#FBF8FA" },
                ["@boolean"] = { fg = "#FBF8FA" },
                ["@constant"] = { fg = "#E0E0E0" },  -- Brighter grey for constants

                -- Comments (Brighter grey for better readability)
                ["@comment"] = { fg = "#D0D0D0" }, -- Much brighter grey
                ["Comment"] = { fg = "#D0D0D0" },
                ["@comment.documentation"] = { fg = "#D0D0D0" },

                -- Operators and Punctuation (Brighter greys for better readability)
                ["@operator"] = { fg = "#D5D5D5" }, -- Brighter grey
                ["@punctuation"] = { fg = "#D5D5D5" },
                ["@punctuation.bracket"] = { fg = "#CDCDCD" },
                ["@punctuation.delimiter"] = { fg = "#C8C8C8" },

                -- Tags and Attributes
                ["@tag"] = { fg = "#FBF8FA" },
                ["@attribute"] = { fg = "#F7F7F7" },
                ["@constructor"] = { fg = "#FBF8FA" },
                ["@constructor.python"] = { fg = "#FBF8FA" },

                -- Python-specific improvements for better readability
                ["@variable.builtin.python"] = { fg = "#F8D2C9" },      -- self, cls in warm accent
                ["@function.builtin.python"] = { fg = "#F8D2C9" },      -- print, len, range, etc.
                ["@keyword.import.python"] = { fg = "#F8D2C9", style = { "bold" } },  -- import, from
                ["@module.python"] = { fg = "#EAEAEA" },                -- module names in imports
                ["@variable.parameter.python"] = { fg = "#E8E8E8" },    -- function parameters

                -- Go-specific improvements for better readability
                ["@variable.builtin.go"] = { fg = "#F8D2C9" },          -- nil, true, false in warm accent
                ["@function.builtin.go"] = { fg = "#F8D2C9" },          -- make, len, cap, append, etc.
                ["@keyword.import.go"] = { fg = "#F8D2C9", style = { "bold" } },    -- import
                ["@keyword.package.go"] = { fg = "#F8D2C9", style = { "bold" } },   -- package
                ["@module.go"] = { fg = "#EAEAEA" },                     -- package names in imports
                ["@type.builtin.go"] = { fg = "#EAEAEA" },               -- int, string, bool, etc.
                ["@variable.parameter.go"] = { fg = "#E8E8E8" },         -- function parameters
                ["@keyword.function.go"] = { fg = "#F8D2C9", style = { "bold" } },  -- func keyword
                ["@keyword.return.go"] = { fg = "#F8D2C9", style = { "bold" } },    -- return keyword

                -- Bash/Shell-specific improvements for better readability
                ["@variable.builtin.bash"] = { fg = "#F8D2C9" },        -- $0, $1, $@, $#, etc.
                ["@function.builtin.bash"] = { fg = "#F8D2C9" },        -- echo, printf, read, test, etc.
                ["@keyword.bash"] = { fg = "#F8D2C9", style = { "bold" } },         -- if, then, else, fi, for, while
                ["@variable.parameter.bash"] = { fg = "#E8E8E8" },      -- function parameters
                ["@string.special.path.bash"] = { fg = "#EAEAEA" },     -- file paths
                ["@punctuation.special.bash"] = { fg = "#E0E0E0" },     -- $, {}, [], etc.
                ["@operator.bash"] = { fg = "#E0E0E0" },                -- &&, ||, |, >, <, etc.

                -- Shell script (sh) - similar to bash
                ["@variable.builtin.sh"] = { fg = "#F8D2C9" },
                ["@function.builtin.sh"] = { fg = "#F8D2C9" },
                ["@keyword.sh"] = { fg = "#F8D2C9", style = { "bold" } },
                ["@variable.parameter.sh"] = { fg = "#E8E8E8" },
                ["@punctuation.special.sh"] = { fg = "#E0E0E0" },
                ["@operator.sh"] = { fg = "#E0E0E0" },

                -- LSP Reference highlights (fix purple color issues)
                LspReferenceRead = { bg = "#3C3C3C", fg = "#E8E8E8" },     -- Light grey background, bright text
                LspReferenceWrite = { bg = "#4A4A4A", fg = "#F0F0F0" },    -- Slightly darker background for writes
                LspReferenceText = { bg = "#383838", fg = "#E0E0E0" },     -- Subtle background for text references

                -- LSP semantic tokens
                ["@lsp.type.class"] = { fg = "#FBF8FA" },
                ["@lsp.type.function"] = { fg = "#F8D2C9" },
                ["@lsp.type.method"] = { fg = "#F8D2C9" },
                ["@lsp.type.variable"] = { fg = "#F0F0F0" },
                ["@lsp.type.property"] = { fg = "#EAEAEA" },
                ["@lsp.type.parameter"] = { fg = "#D2D2D2" },

                -- Diagnostics
                DiagnosticError = { fg = "#FF9E9E" },
                DiagnosticWarn = { fg = "#F8D2C9" },
                DiagnosticInfo = { fg = "#CECECE" },  -- Brighter grey for better visibility
                DiagnosticHint = { fg = "#D2D2D2" },  -- Brighter grey for better visibility

                -- UI elements (Enhanced contrast for keratoconus)
                LineNr = { fg = "#B5B5B5" },                           -- Brighter grey for better line number visibility
                CursorLineNr = { fg = "#F8D2C9", style = { "bold" } }, -- Warmer peach
                CursorLine = { bg = "#2A2D42" },                       -- Better contrast, slightly more visible
                Visual = { bg = "#3C4058" },                           -- Improved visual selection contrast
                Search = { bg = "#C0C0C0", fg = "#1C1E2D" },
                IncSearch = { bg = "#F8D2C9", fg = "#1C1E2D" },

                -- Quickfix and location list (fix purple color issues)
                QuickFixLine = { bg = "#3A3A3A", fg = "#E8E8E8" },        -- Current quickfix line
                qfLineNr = { fg = "#B8B8B8" },                            -- Quickfix line numbers
                qfFileName = { fg = "#F8D2C9" },                          -- Quickfix file names in warm accent
                qfSeparator = { fg = "#8A8A8A" },                         -- Quickfix separators

                -- Telescope highlights (fix purple color issues)
                TelescopeSelection = { bg = "#3A3A3A", fg = "#F0F0F0" },          -- Selected item
                TelescopeSelectionCaret = { fg = "#F8D2C9" },                     -- Selection caret in warm accent
                TelescopeMultiSelection = { bg = "#2E2E2E", fg = "#E8E8E8" },     -- Multi-selected items
                TelescopeMultiIcon = { fg = "#F8D2C9" },                          -- Multi-selection icon

                -- Telescope borders and UI
                TelescopeBorder = { fg = "#8A8A8A" },                             -- Border color
                TelescopePromptBorder = { fg = "#B0B0B0" },                       -- Prompt border
                TelescopeResultsBorder = { fg = "#8A8A8A" },                      -- Results border
                TelescopePreviewBorder = { fg = "#8A8A8A" },                      -- Preview border

                -- Telescope text and titles
                TelescopePromptTitle = { bg = "#F8D2C9", fg = "#1C1E2D", style = { "bold" } }, -- Prompt title
                TelescopeResultsTitle = { bg = "#B8B8B8", fg = "#1C1E2D", style = { "bold" } }, -- Results title
                TelescopePreviewTitle = { bg = "#A0A0A0", fg = "#1C1E2D", style = { "bold" } }, -- Preview title

                -- Telescope matching and highlighting
                TelescopeMatching = { fg = "#F8D2C9", style = { "bold" } },       -- Matching text in warm accent
                TelescopePromptPrefix = { fg = "#F8D2C9" },                       -- Prompt prefix (>) in warm accent

                -- Markdown preview (render-markdown.nvim) highlights (fix purple color issues)
                RenderMarkdownCodeInline = { bg = "#2A2A2A", fg = "#F8D2C9" },    -- Inline code in warm accent
                RenderMarkdownCode = { bg = "#242424" },                          -- Code blocks background
                RenderMarkdownH1Bg = { bg = "#2D2D2D" },                          -- H1 background
                RenderMarkdownH2Bg = { bg = "#282828" },                          -- H2 background
                RenderMarkdownH3Bg = { bg = "#262626" },                          -- H3 background
                RenderMarkdownH4Bg = { bg = "#242424" },                          -- H4 background
                RenderMarkdownH5Bg = { bg = "#222222" },                          -- H5 background
                RenderMarkdownH6Bg = { bg = "#202020" },                          -- H6 background

                -- Markdown headers in warm accent instead of purple
                RenderMarkdownH1 = { fg = "#F8D2C9", style = { "bold" } },       -- H1 text
                RenderMarkdownH2 = { fg = "#F8D2C9", style = { "bold" } },       -- H2 text
                RenderMarkdownH3 = { fg = "#F8D2C9", style = { "bold" } },       -- H3 text
                RenderMarkdownH4 = { fg = "#E8E8E8", style = { "bold" } },       -- H4 text
                RenderMarkdownH5 = { fg = "#E0E0E0", style = { "bold" } },       -- H5 text
                RenderMarkdownH6 = { fg = "#D8D8D8", style = { "bold" } },       -- H6 text

                -- Other markdown elements
                RenderMarkdownBullet = { fg = "#F8D2C9" },                        -- Bullet points in warm accent
                RenderMarkdownQuote = { fg = "#C0C0C0" },                         -- Block quotes
                RenderMarkdownLink = { fg = "#F8D2C9", style = { "underline" } }, -- Links in warm accent
                RenderMarkdownSign = { fg = "#B8B8B8" },                          -- Signs/icons
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
                telescope = {
                    enabled = true,
                    style = "nvchad", -- or "borderless" for cleaner look
                },
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
