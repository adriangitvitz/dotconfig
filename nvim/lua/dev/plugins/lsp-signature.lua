return {
    "ray-x/lsp_signature.nvim",
    event = "User BaseFile",
    opts = function()
        -- Apply globals from 1-options.lua
        local is_enabled = vim.g.lsp_signature_enabled
        local round_borders = {}
        if vim.g.lsp_round_borders_enabled then
            round_borders = { border = 'rounded' }
        end
        return {
            -- Window mode
            floating_window = is_enabled, -- Display it as floating window.
            hi_parameter = "IncSearch", -- Color to highlight floating window.
            handler_opts = round_borders, -- Window style

            -- Hint mode
            hint_enable = false, -- Display it as hint.
            hint_prefix = "👈 ",

            -- Additionally, you can use <space>uH to toggle inlay hints.
            toggle_key_flip_floatwin_setting = is_enabled
        }
    end,
    config = function(_, opts) require('lsp_signature').setup(opts) end
}
