return {
    {
        "gelguy/wilder.nvim",
        dependencies = { "romgrk/fzy-lua-native" },
        build = ":UpdateRemotePlugins",
        config = function()
            local wilder = require("wilder")
            wilder.setup({ modes = { ':', '/', '?' } })

            wilder.set_option('pipeline', wilder.branch(
                wilder.cmdline_pipeline({
                    fuzzy = 1,
                    fuzzy_filter = wilder.lua_fzy_filter(),
                    use_python = false -- Disable Python for pure Lua setup
                }),
                wilder.search_pipeline()
            ))

            wilder.set_option('renderer', wilder.popupmenu_renderer(
                wilder.popupmenu_border_theme({
                    highlights = {
                        border = 'Normal', -- highlight to use for the border
                    },
                    border = 'rounded',
                    left = {
                        ' ',
                        wilder.popupmenu_devicons(),
                        wilder.popupmenu_buffer_flags({
                            flags = ' a + ',
                            icons = { ['+'] = '', a = '', h = '' },
                        }),
                    },
                    right = {
                        ' ',
                        wilder.popupmenu_scrollbar(),
                    },
                })
            ))

            wilder.set_option('renderer', wilder.renderer_mux({
                [':'] = wilder.popupmenu_renderer({
                    highlighter = wilder.lua_fzy_highlighter(),
                    left = { wilder.popupmenu_devicons() },
                    right = { ' ', wilder.popupmenu_scrollbar() }
                }),
                ['/'] = wilder.wildmenu_renderer({
                    highlighter = wilder.lua_fzy_highlighter()
                })
            }))

            vim.keymap.set('c', '<Tab>', function()
                if wilder.in_context() then
                    return wilder.next()
                end
                return '<Tab>'
            end, { expr = true })

            vim.keymap.set('c', '<S-Tab>', function()
                if wilder.in_context() then
                    return wilder.previous()
                end
                return '<S-Tab>'
            end, { expr = true })
        end
    }
}
