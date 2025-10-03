return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { 'markdown', 'norg', 'quarto' },
        opts = {
            file_types = { 'markdown', 'norg', 'quarto' },
            code = {
                sign = false,
                width = 'block',
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            },
            bullet = {
                icons = { '●', '○', '◆', '◇' },
            },
            checkbox = {
                unchecked = {
                    icon = '󰄱 ',
                    highlight = 'ObsidianTodo',
                },
                checked = {
                    icon = '󰱒 ',
                    highlight = 'ObsidianDone',
                },
                custom = {
                    todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'ObsidianTodo' },
                    important = { raw = '[!]', rendered = '󰀪 ', highlight = 'DiagnosticWarn' },
                },
            },
            link = {
                enabled = true,
                image = '󰥶 ',
                email = '󰀓 ',
                hyperlink = '󰌹 ',
                highlight = 'RenderMarkdownLink',
                wiki = { icon = '󱉯 ', highlight = 'RenderMarkdownWikiLink' },
            },
            latex = {
                enabled = true,
                converter = 'latex2text',
                highlight = 'RenderMarkdownMath',
                top_pad = 0,
                bottom_pad = 0,
            },
        },
        config = function(_, opts)
            require('render-markdown').setup(opts)
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = 'cd app && npx --yes yarn install',
        keys = {
            { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' },
        },
        config = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ''
            vim.g.mkdp_browser = ''
            vim.g.mkdp_echo_preview_url = 0
            vim.g.mkdp_browserfunc = ''
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = 'middle',
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = false,
                disable_filename = 0,
                toc = {}
            }
            vim.g.mkdp_markdown_css = ''
            vim.g.mkdp_highlight_css = ''
            vim.g.mkdp_port = ''
            vim.g.mkdp_page_title = '「${name}」'
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
    }
}
