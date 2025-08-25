return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local colors = {
            bg       = 'none',    -- keep transparent to match editor background
            bg_dark  = '#1C1E2D', -- Serendipity base
            panel    = '#2C2E3D', -- subtle panel/bar
            fg       = '#DEE0EF', -- primary foreground
            muted    = '#8D8F9E',

            blue     = '#5BA2D0', -- primary accent
            blue_alt = '#94B8FF', -- secondary accent
            cyan     = '#9CCFD8',
            purple   = '#A78BFA',
            red      = '#EE8679',
            gold     = '#F8D2C9',
        }

        local mode_color = {
            n      = colors.blue,
            i      = colors.cyan,
            v      = colors.gold,
            V      = colors.gold,
            ['']   = colors.gold,
            c      = colors.purple,
            no     = colors.red,
            s      = colors.gold,
            S      = colors.gold,
            ic     = colors.gold,
            R      = colors.purple,
            Rv     = colors.purple,
            cv     = colors.red,
            ce     = colors.red,
            r      = colors.cyan,
            rm     = colors.cyan,
            ['r?'] = colors.cyan,
            ['!']  = colors.red,
            t      = colors.red,
        }

        local custom_theme = {
            normal   = {
                a = { fg = colors.bg_dark, bg = colors.blue, gui = 'bold' },
                b = { fg = colors.fg, bg = colors.panel },
                c = { fg = colors.fg, bg = colors.bg },
            },
            insert   = { a = { fg = colors.bg_dark, bg = colors.cyan, gui = 'bold' } },
            visual   = { a = { fg = colors.bg_dark, bg = colors.gold, gui = 'bold' } },
            replace  = { a = { fg = colors.bg_dark, bg = colors.red, gui = 'bold' } },
            inactive = {
                a = { fg = colors.muted, bg = colors.bg, gui = 'bold' },
                b = { fg = colors.muted, bg = colors.bg },
                c = { fg = colors.muted, bg = colors.bg },
            },
        }

        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        lualine.setup({
            extensions = { "mason", "trouble", "toggleterm" },
            options = {
                section_separators   = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                theme                = custom_theme,
            },
            sections = {
                lualine_a = {
                    { "mode" },
                    {
                        color = function()
                            return { fg = mode_color[vim.fn.mode()], bg = colors.bg }
                        end,
                    },
                },
                lualine_c = {
                    function()
                        local fn = vim.fn
                        local path = fn.expand("%:p")
                        if path == "" then return "" end
                        local cwd = fn.getcwd()
                        if path:find(cwd, 1, true) == 1 then
                            path = path:sub(#cwd + 2)
                        end
                        local sep = package.config:sub(1, 1)
                        local parts = vim.split(path, "[\\/]")

                        if #parts > 3 then
                            parts = { parts[31], "…", parts[#parts - 1], parts[#parts] }
                        end
                        return table.concat(parts, sep)
                    end,
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = colors.red }, -- warm accent for visibility
                    },
                    { "fileformat" },
                    { "filetype" },
                },
            },
        })
    end,
}
