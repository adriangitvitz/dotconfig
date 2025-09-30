return {
    "sschleemilch/slimline.nvim",
    opts = {
        style = 'fg', -- Use foreground style for better transparency support
        bold = true,

        -- Global highlights matching iceberg-tokyo colorscheme
        hl = {
            base = 'Normal', -- transparent background
            primary = 'Normal', -- Main text color (#a9b1d6)
            secondary = 'Comment', -- Secondary text color (#9da3c4)
        },

        -- Component-specific colors matching iceberg-tokyo palette
        configs = {
            mode = {
                hl = {
                    normal = 'Function',    -- Blue color (#84a0c6)
                    visual = 'Statement',   -- Blue color (#84a0c6)
                    insert = 'String',      -- Cyan color (#89b8c2)
                    replace = 'Constant',   -- Purple color (#a093c7)
                    command = 'Special',    -- Green color (#b4be82)
                    other = 'Function',     -- Blue color (#84a0c6)
                },
            },
            path = {
                hl = {
                    primary = 'Normal',     -- Main foreground (#a9b1d6)
                    secondary = 'Comment',  -- Comment color (#9da3c4)
                },
            },
            git = {
                hl = {
                    primary = 'String',     -- Cyan color (#89b8c2)
                    secondary = 'Comment',  -- Comment color (#9da3c4)
                },
            },
            diagnostics = {
                hl = {
                    error = 'DiagnosticError',   -- Red (#ea8988)
                    warn = 'DiagnosticWarn',     -- Orange (#e2a478)
                    hint = 'DiagnosticHint',     -- Comment (#9da3c4)
                    info = 'DiagnosticInfo',     -- Cyan (#89b8c2)
                },
            },
            filetype_lsp = {
                hl = {
                    primary = 'Type',       -- Blue (#84a0c6)
                    secondary = 'Comment',  -- Comment (#9da3c4)
                },
            },
            progress = {
                follow = 'mode', -- Follow mode colors
            },
        },

        -- Minimal spacing for cleaner look
        spaces = {
            components = ' ',
            left = ' ',
            right = ' ',
        },
    },

    config = function(_, opts)
        require('slimline').setup(opts)

        -- Set custom transparent highlights after setup
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                -- Make the entire statusline completely transparent
                vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

                -- Ensure transparent background for slimline base
                vim.api.nvim_set_hl(0, "Slimline", { bg = "NONE", fg = "NONE" })

                -- Override ALL slimline highlight groups to be completely transparent
                local highlight_groups = {
                    "Slimline",
                    "SlimlineModeNormal", "SlimlineModeNormalSep", "SlimlineModeNormalSep2Sec",
                    "SlimlineModeVisual", "SlimlineModeVisualSep", "SlimlineModeVisualSep2Sec",
                    "SlimlineModeInsert", "SlimlineModeInsertSep", "SlimlineModeInsertSep2Sec",
                    "SlimlineModeReplace", "SlimlineModeReplaceSep", "SlimlineModeReplaceSep2Sec",
                    "SlimlineModeCommand", "SlimlineModeCommandSep", "SlimlineModeCommandSep2Sec",
                    "SlimlineModeOther", "SlimlineModeOtherSep", "SlimlineModeOtherSep2Sec",
                    "SlimlineModeSecondary",
                    "SlimlinePathPrimary", "SlimlinePathPrimarySep", "SlimlinePathPrimarySep2Sec",
                    "SlimlinePathSecondary", "SlimlinePathSecondarySep",
                    "SlimlineGitPrimary", "SlimlineGitPrimarySep", "SlimlineGitPrimarySep2Sec",
                    "SlimlineGitSecondary", "SlimlineGitSecondarySep",
                    "SlimlineFiletype_lspPrimary", "SlimlineFiletype_lspPrimarySep", "SlimlineFiletype_lspPrimarySep2Sec",
                    "SlimlineFiletype_lspSecondary", "SlimlineFiletype_lspSecondarySep",
                    "SlimlineProgressPrimary", "SlimlineProgressPrimarySep", "SlimlineProgressPrimarySep2Sec",
                    "SlimlineProgressSecondary", "SlimlineProgressSecondarySep",
                    "SlimlineRecordingPrimary", "SlimlineRecordingPrimarySep", "SlimlineRecordingPrimarySep2Sec",
                    "SlimlineRecordingSecondary", "SlimlineRecordingSecondarySep",
                    "SlimlineSearchcountPrimary", "SlimlineSearchcountPrimarySep", "SlimlineSearchcountPrimarySep2Sec",
                    "SlimlineSearchcountSecondary", "SlimlineSearchcountSecondarySep",
                    "SlimlineSelectioncountPrimary", "SlimlineSelectioncountPrimarySep", "SlimlineSelectioncountPrimarySep2Sec",
                    "SlimlineSelectioncountSecondary", "SlimlineSelectioncountSecondarySep",
                    "SlimlineDiagnosticsHint", "SlimlineDiagnosticsHintSep",
                    "SlimlineDiagnosticsInfo", "SlimlineDiagnosticsInfoSep",
                    "SlimlineDiagnosticsWarn", "SlimlineDiagnosticsWarnSep",
                    "SlimlineDiagnosticsError", "SlimlineDiagnosticsErrorSep",
                }

                -- Set all highlight groups to have no background
                for _, group in ipairs(highlight_groups) do
                    local existing = vim.api.nvim_get_hl(0, { name = group })
                    if existing and next(existing) then
                        existing.bg = nil -- Remove background completely
                        vim.api.nvim_set_hl(0, group, existing)
                    else
                        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
                    end
                end
            end,
        })

        -- Trigger the autocmd immediately if colorscheme is already loaded
        if vim.g.colors_name then
            vim.cmd("doautocmd ColorScheme")
        end
    end,
}
