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

        local function get_short_cwd()
            local cwd = vim.fn.getcwd()
            local home = vim.env.HOME
            if cwd:find(home, 1, true) == 1 then
                cwd = "~" .. cwd:sub(#home + 1)
            end
            return vim.fn.fnamemodify(cwd, ":t")
        end

        local function get_smart_filepath()
            local path = vim.fn.expand("%:.")
            if path == "" then return "[No Name]" end
            
            local parts = vim.split(path, "/")
            if #parts > 3 then
                return table.concat({ parts[1], "…", parts[#parts - 1], parts[#parts] }, "/")
            end
            return path
        end

        local function get_lsp_clients()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if next(clients) == nil then return "" end
            
            local names = {}
            for _, client in pairs(clients) do
                table.insert(names, client.name)
            end
            return " " .. table.concat(names, ", ")
        end

        local function get_diagnostics_count()
            local diagnostics = vim.diagnostic.get(0)
            local counts = { errors = 0, warnings = 0, hints = 0, info = 0 }
            
            for _, diagnostic in pairs(diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    counts.errors = counts.errors + 1
                elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                    counts.warnings = counts.warnings + 1
                elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                    counts.hints = counts.hints + 1
                elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                    counts.info = counts.info + 1
                end
            end
            
            local result = {}
            if counts.errors > 0 then
                table.insert(result, " " .. counts.errors)
            end
            if counts.warnings > 0 then
                table.insert(result, " " .. counts.warnings)
            end
            if counts.hints > 0 then
                table.insert(result, " " .. counts.hints)
            end
            
            return table.concat(result, " ")
        end

        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        lualine.setup({
            extensions = { "mason", "trouble", "toggleterm", "nvim-tree", "lazy" },
            options = {
                icons_enabled = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "│", right = "│" },
                theme = custom_theme,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str) 
                            return str:sub(1, 3):upper() 
                        end,
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.purple },
                        fmt = function(str)
                            if #str > 20 then
                                return str:sub(1, 17) .. "…"
                            end
                            return str
                        end,
                    },
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                        diff_color = {
                            added = { fg = colors.cyan },
                            modified = { fg = colors.gold },
                            removed = { fg = colors.red },
                        },
                    },
                },
                lualine_c = {
                    {
                        get_short_cwd,
                        icon = "",
                        color = { fg = colors.muted },
                    },
                    {
                        get_smart_filepath,
                        color = { fg = colors.fg },
                    },
                    {
                        "filesize",
                        cond = function()
                            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                        end,
                        color = { fg = colors.muted },
                    },
                    {
                        function()
                            if vim.bo.modified then
                                return ""
                            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                                return ""
                            end
                            return ""
                        end,
                        color = { fg = colors.red },
                    },
                },
                lualine_x = {
                    {
                        get_diagnostics_count,
                        color = { fg = colors.red },
                        cond = function()
                            return get_diagnostics_count() ~= ""
                        end,
                    },
                    {
                        get_lsp_clients,
                        icon = "",
                        color = { fg = colors.blue_alt },
                        cond = function()
                            return get_lsp_clients() ~= ""
                        end,
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = colors.red },
                    },
                    {
                        "encoding",
                        cond = function()
                            return vim.bo.fileencoding ~= "utf-8"
                        end,
                        color = { fg = colors.muted },
                    },
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        },
                        cond = function()
                            return vim.bo.fileformat ~= "unix"
                        end,
                        color = { fg = colors.muted },
                    },
                },
                lualine_y = {
                    {
                        "progress",
                        color = { fg = colors.muted },
                    },
                },
                lualine_z = {
                    {
                        "location",
                        color = { fg = colors.fg, bg = colors.panel },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        get_smart_filepath,
                        color = { fg = colors.muted },
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}